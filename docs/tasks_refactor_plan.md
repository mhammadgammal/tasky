# Tasks Feature Refactor Plan

Extends the error-handling refactor already applied to `features/authentication`
and `features/profile` to `features/tasks`: replace the ad-hoc `ApiResponse`
(`response`/`error` nullable pair) with `Either<Failure, T>`, routed through the
existing `handleResponse` + `ErrorMapper` pipeline (`core/network/`), so every
layer gets typed, localized (`.tr()`) failures instead of raw HTTP status ints.

Reference implementation: `features/authentication/data/repo/authentication_repo_impl.dart`
and `features/profile/data/repo/profile_repo.dart` — both already follow the
target shape end-to-end.

## Current state

- `TasksRepository` / `TasksRepositoryImpl` return `Future<ApiResponse>` from
  every method, each with its own duplicated `try { ... } on DioException`
  block (`data/repository/tasks_repository_impl.dart`).
- The four task use cases each unwrap `ApiResponse` by hand and re-wrap into
  `Either`, but **backwards** relative to the auth/profile convention:
  `Either<TaskModel, int>` — `Left` = success value, `Right` = raw HTTP status
  code. (`domain/use_case/{add_task_use_case,get_task,get_all_tasks_use_case}.dart`)
- `DeleteTaskUseCase` returns `Either<void, int>`; `UpdateTaskUseCase` returns
  `Either<Response, int>`, leaking `dio.Response` into the domain layer.
- Cubits (`TasksCubit`, `AddTaskCubit`, `TaskDetailsCubit`) call `.fold` with
  the success callback first (matching the backwards `Either`), and turn the
  `int` error code into text via `ApiErrorHandler.handelErrorMessage(int)`
  (`core/utils/api_utils/api_error_handler.dart`) — a hardcoded, unlocalized
  switch statement, unrelated to the `Failure`/`ErrorMapper` machinery used
  everywhere else.
- `TasksCubit.fetchTasksPage` special-cases `errorCode == 401` to emit
  `SessionTerminated()`, then `throw Exception(...)` — the `throw` is required
  by `PaginatableList.pageLoader`'s contract (`core/widgets/paginatable_list.dart`
  wraps the call in `try/catch` and only exposes a boolean `_isError`), so this
  needs to keep throwing after the refactor, just driven off a typed `Failure`
  instead of a magic number.
- Some failure states carry no message at all (`TaskLoadFailureState`,
  `TaskDeletedFailedState` in both cubits), so the corresponding UI can't show
  anything useful — inconsistent with `TaskUpdateFailureState`/`TaskAddFailedState`,
  which already carry a string.

## Target shape

### 1. `domain/repository/tasks_repository.dart` + `data/repository/tasks_repository_impl.dart`

```dart
abstract interface class TasksRepository {
  Future<Either<Failure, List<TaskModel>>> getAllTasks(int pageNumber);
  Future<Either<Failure, TaskModel>> getTask(String taskId);
  Future<Either<Failure, TaskModel>> addTask(TaskModel task);
  Future<Either<Failure, TaskModel>> editTask(TaskModel task);
  Future<Either<Failure, Unit>> deleteTask(String taskId);
}
```

Each `TasksRepositoryImpl` method collapses to a `handleResponse(...)` call,
same shape as `AuthenticationRepoImpl.login`:

```dart
@override
Future<Either<Failure, TaskModel>> getTask(String taskId) => handleResponse(
      _apiService.getTask(taskId),
      (response) => TaskModel.fromJson(response.data),
    );
```

- `getAllTasks` maps `response.data` (a `List`) into `List<TaskModel>` inside
  the `handleResponse` mapper — this moves the loop currently sitting in
  `GetAllTasksUseCase.perform` down into the repo, matching where parsing
  happens for every other endpoint.
- `deleteTask` has no response body to parse; map to dartz's `Unit` (`(_) =>
  unit`) instead of `null`, so the success type is a real type rather than
  `void`.
- `addTask`/`editTask` keep the existing `_uploadImage` step before the
  `handleResponse` call (upload failures should also produce a `Failure` —
  wrap the image upload in the same try path or let a thrown `DioException`
  from `_uploadImage` propagate into `handleResponse`'s catch, whichever reads
  cleaner once written).
- Drop the `dio`/`ApiResponse` imports once every method is converted.

### 2. Use cases

Each use case's generic parameter changes from `Either<T, int>` to
`Either<Failure, T>`, and `perform` just forwards the repo's `Either` (no more
manual `apiResponse.response != null` branching).

`GetTaskUseCase` is the one case that does real work after unwrapping (the
`File(task.imagePath).exists()` check), and that work is async, which
`Either.fold`'s sync callbacks can't express directly. Branch manually instead:

```dart
class GetTaskUseCase
    implements ParameterUseCase<Either<Failure, TaskModel>, TaskIdParameter> {
  Future<Either<Failure, TaskModel>> perform(TaskIdParameter parameter) async {
    final result = await _repo.getTask(parameter.taskId);
    if (result.isRight()) {
      final task = (result as Right<Failure, TaskModel>).value;
      task.isImageExist = await File(task.imagePath).exists();
    }
    return result;
  }
}
```

- `AddTaskUseCase`, `UpdateTaskUseCase`: `perform` becomes a one-line
  passthrough of `_repo.addTask(...)` / `_repo.editTask(...)` — no leftover
  `Response`/status-code handling. `UpdateTaskUseCase` return type changes
  from `Either<Response, int>` to `Either<Failure, TaskModel>`.
- `DeleteTaskUseCase`: passthrough of `_repo.deleteTask(...)`, return type
  `Either<Failure, Unit>`.
- `GetAllTasksUseCase`: passthrough of `_repo.getAllTasks(...)` now that
  parsing moved to the repo; return type `Either<Failure, List<TaskModel>>`.

### 3. Cubits

Flip every `.fold(success, error)` call to `.fold(failure, success)`
(matching `LoginCubit`/`RegisterCubit`/`ProfileCubit`), and replace
`ApiErrorHandler.handelErrorMessage(intCode)` with `failure.message`:

- **`TasksCubit.fetchTasksPage`** — keep the `throw` (required by
  `PaginatableList`), but key session termination off type, not a magic
  number:
  ```dart
  return pageResult.fold((failure) {
    if (failure is UnauthorizedFailure) emit(SessionTerminated());
    throw Exception(failure.message ?? 'Failed to fetch tasks');
  }, (fetched) {
    tasks.addAll(fetched);
    return fetched.where(_matchesSelectedType).toList();
  });
  ```
- **`TasksCubit.deleteTask`** — `emit(TaskDeletedFailedState(message: failure.message ?? ...))`.
- **`AddTaskCubit.addTask`** — drop the `ApiErrorHandler` import/call; use
  `failure.message` straight into `TaskAddFailedState`.
- **`TaskDetailsCubit.getTask`** — `TaskLoadFailureState` needs a `message`
  field (see state changes below) so the failure is actually visible.
- **`TaskDetailsCubit.updateTask`** — same swap, drop `ApiErrorHandler`.
- **`TaskDetailsCubit.deleteTask`** — same as `TasksCubit.deleteTask`.

### 4. States

Add a `message` field wherever a failure state currently has none, for
consistency with `TaskUpdateFailureState`/`TaskAddFailedState`:

- `tasks_state.dart`: `TaskDeletedFailedState({required this.message})`.
- `task_details_state.dart`: `TaskLoadFailureState({required this.message})`,
  `TaskDeletedFailedState({required this.message})`.

Then wire the corresponding screens (`tasks_screen.dart`,
`task_details_screen.dart`/`task_details_body.dart`) to actually surface
`state.message`, the same way `add_task.dart` already shows `state.e`.

### 5. Cleanup once tasks is the last consumer

`features/tasks` is currently the only feature still using `ApiResponse` and
`ApiErrorHandler`. After this migration:

- grep for remaining references to confirm nothing else uses them
  (`rg "ApiResponse|ApiErrorHandler" lib`);
- delete `core/utils/api_utils/api_response.dart` and
  `core/utils/api_utils/api_error_handler.dart`.

### 6. Verification

- `flutter analyze` should be clean for `lib/features/tasks` (mirrors the
  zero-error bar hit for authentication and profile).
- DI (`core/di/di.dart`) already registers the concrete types
  (`TasksRepositoryImpl`, `TaskApiService`, each use case) matching what the
  constructors expect, so — unlike authentication/profile — no interface vs.
  concrete-type registration bug is expected here; still worth a pass after
  the signature changes since GetIt mismatches are runtime-only and won't
  show up in `flutter analyze`.
- Manually exercise: task list pagination + pull-to-refresh (including a
  simulated 401 to confirm `SessionTerminated` still fires), add task,
  edit/update task, delete task from both the list and the details screen.

## Suggested order

1. `tasks_repository.dart` + `tasks_repository_impl.dart` (repo layer, isolated).
2. The four use cases (compile errors will pinpoint every call site).
3. States (`tasks_state.dart`, `task_details_state.dart`, `add_task_state.dart`
   if it needs touching).
4. Cubits (`TasksCubit`, `AddTaskCubit`, `TaskDetailsCubit`).
5. Screens that need to display the new failure messages.
6. Delete `ApiResponse` / `ApiErrorHandler` and confirm `flutter analyze` is clean.
