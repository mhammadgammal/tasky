# Tasky

Tasky is a cross-platform task management app built with Flutter. Users can
register/login, create and manage tasks with status and priority, share or
import a task via QR code, and view their profile — all backed by a REST API.

## Features

- **Authentication** — register, login, JWT-based sessions with silent
  refresh-token handling and automatic logout on session expiry.
- **Tasks** — create, edit, delete tasks with status and priority, paginated
  task list, filtering via selection chips, image thumbnails.
- **QR code** — generate a QR code for a task and scan a QR code to open it.
- **Profile** — view account details (name, phone, level, experience,
  location) with a copy-to-clipboard shortcut for the phone number.
- **Localization** — English and Arabic (`assets/localization`).
- **Onboarding** — first-run boarding screens.

## Tech stack

- **Flutter / Dart** (SDK `>=3.4.3 <4.0.0`)
- **flutter_bloc** — state management (Cubit)
- **get_it** — dependency injection / service locator
- **dio** — networking, with request and refresh-token interceptors
- **dartz** — functional error handling (`Either<Failure, T>`)
- **shared_preferences** — local cache (tokens, user data)
- **qr_flutter** / **qr_code_scanner** — QR generation and scanning
- **infinite_scroll_pagination** — paginated task list
- **image_picker**, **phone_form_field**, **shimmer**, **fluttertoast**

## Architecture

The app follows **Clean Architecture**, split per feature into:

```
lib/features/<feature>/
├── data/            # data sources, models, repository implementations
├── domain/          # entities, repository interfaces, use cases
└── presentation/    # screens, widgets, Cubit + state
```

State management is handled with **BLoC/Cubit**: each screen listens to a
`Cubit` that calls use cases/repositories and emits immutable `State`
objects. Shared infrastructure (networking, caching, DI, theming, routing,
localization, reusable widgets) lives under `lib/core/`.

> This branch also includes an MVVM variant of the Profile feature
> (`lib/features/profile/presentation/view_model/profile_view_model.dart`)
> alongside the original Cubit implementation, as a side-by-side comparison
> of the two patterns.

## Getting started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `>=3.4.3`
  (includes Dart)
- A configured platform toolchain for whichever target you want to run:
  Xcode (iOS/macOS), Android Studio/SDK (Android), or a desktop/web toolchain
- A connected device, simulator/emulator, or a desktop/web target

### Setup

```bash
# 1. Clone the repository
git clone <repository-url>
cd tasky

# 2. Install dependencies
flutter pub get

# 3. Run the app (pick a connected device/emulator)
flutter run
```

The API base URL is configured in
`lib/core/network/api_end_points.dart` — update `ApiEndPoints.baseUrl` if
you need to point the app at a different backend.

### Useful commands

```bash
flutter analyze     # static analysis
flutter test        # run unit/widget tests
flutter build apk    # Android release build
flutter build ios    # iOS release build
```

## Project structure

```
lib/
├── core/            # DI, networking, caching, theming, routing,
│                     localization, shared widgets
└── features/
    ├── authentication/
    ├── boarding/
    ├── profile/
    └── tasks/
```
