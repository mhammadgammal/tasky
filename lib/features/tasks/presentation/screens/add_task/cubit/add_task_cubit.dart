import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/core/base_use_case/base_parameter.dart';
import 'package:tasky/features/tasks/domain/entity/task_model.dart';

import '../../../../domain/use_case/add_task_use_case.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  final AddTaskUseCase _useCase;

  AddTaskCubit(this._useCase) : super(AddTaskInitial());

  static AddTaskCubit get(BuildContext context) => BlocProvider.of(context);

  String selectedPriority = 'low';

  List<String> items = ['low', 'medium', 'high'];
  var formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final dateController = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  XFile? imageFile;

  late TaskModel task;

  void onPriorityChanged(value) {
    selectedPriority = value;
    emit(PriorityChangedState());
  }

  handleImagePick() async {
    imageFile = await imagePicker.pickImage(source: ImageSource.gallery);
    emit(ImagePickedState());
  }

  Future<void> addTask() async {
    var result = await _useCase.perform(TaskInstanceParameter(TaskModel(
        taskId: '-1',
        title: titleController.text,
        description: descController.text,
        imagePath: imageFile == null ? "" : imageFile!.path,
        priority: selectedPriority,
        status: 'waiting',
        userId: '-1',
        timeStampCreatedAt: 'timeStampCreatedAt',
        timeStampUpdatedAt: 'timeStampUpdatedAt')));
    result.fold((failure) {
      emit(TaskAddFailedState(failure.message ?? 'Failed to add task'));
    }, (task) async {
      this.task = task;
      bool isExist = await File(task.imagePath).exists();
      this.task.isImageExist = isExist;
      emit(TaskAddedSuccessState());
    });
  }

  String? validatePriorityDropdown(String? value) =>
      value == null || value.isEmpty
          ? 'Please select a priority for your task'
          : null;
}
