import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/theme/app_color.dart';
import 'package:tasky/core/utils/screen_utils/screen_util.dart';
import 'package:tasky/core/widgets/auth_error_dialogue.dart';
import 'package:tasky/core/widgets/date_picker.dart';
import 'package:tasky/core/widgets/default_form_field.dart';
import 'package:tasky/core/widgets/tasky_button.dart';
import 'package:tasky/features/tasks/presentation/screens/add_task/cubit/add_task_cubit.dart';

class AddNewTaskScreen extends StatelessWidget {
  const AddNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTaskCubit, AddTaskState>(
      listener: (context, state) {
        if (state is TaskAddedSuccessState) {
          Navigator.pop(context, AddTaskCubit.get(context).task);
        } else if (state is TaskAddFailedState) {
          AuthErrorDialogue(errorMessage: state.e);
        }
      },
      builder: (context, state) {
        var cubit = AddTaskCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: const Text('Add New Task'),
          ),
          body: Form(
            key: cubit.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 20.0, horizontal: 12.0),
                child: Column(
                  children: [
                    cubit.imageFile == null
                        ? GestureDetector(
                            onTap: () => cubit.handleImagePick(),
                            child: DottedBorder(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                borderType: BorderType.RRect,
                                color: AppColor.mainColor,
                                radius: const Radius.circular(12.0),
                                child: Container(
                                  // width: ScreenUtil.getScreenWidth(context),
                                  height: ScreenUtil.getScreenHeight(context) *
                                      0.06,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_photo_alternate_outlined,
                                        size: 30.0,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text('Add Img')
                                    ],
                                  ),
                                )),
                          )
                        : SizedBox(
                            width: ScreenUtil.getScreenWidth(context),
                            height: ScreenUtil.getScreenHeight(context) * 0.35,
                            child: Image.file(File(cubit.imageFile!.path))),
                    const SizedBox(
                      height: 20.0,
                    ),
                    DefaultFormFiled(
                        controller: cubit.titleController,
                        inputType: TextInputType.text,
                        fieldLabel: 'Task Title',
                        icon: null,
                        validate: (value) => value == null || value.isEmpty
                            ? 'Task title is required'
                            : null),
                    const SizedBox(
                      height: 20.0,
                    ),
                    DefaultFormFiled(
                        controller: cubit.descController,
                        inputType: TextInputType.text,
                        fieldLabel: 'Task Description',
                        icon: null,
                        validate: (value) => value == null || value.isEmpty
                            ? 'Task title is required'
                            : null),
                    const SizedBox(
                      height: 20.0,
                    ),
                    DropdownButtonFormField(
                        value: cubit.selectedPriority,
                        iconEnabledColor: AppColor.mainColor,
                        iconSize: 24.0,
                        selectedItemBuilder: (context) => cubit.items
                            .map((e) => Padding(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 15.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.flag_outlined,
                                        color: AppColor.mainColor,
                                        size: 30.0,
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        '${cubit.selectedPriority} Priority',
                                        style: const TextStyle(
                                            color: AppColor.mainColor,
                                            fontSize: 20.0),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                        decoration: InputDecoration(
                            labelStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none), // Add a border
                            filled: true,
                            fillColor: AppColor.paleLavender),
                        items: List.generate(
                            cubit.items.length,
                            (index) => DropdownMenuItem<String>(
                                value: cubit.items[index],
                                child: Text(cubit.items[index]))),
                        onChanged: cubit.onPriorityChanged),
                    const SizedBox(
                      height: 20.0,
                    ),
                    DatePicker(
                        datePickerController: cubit.dateController,
                        datePickerLabel: 'Choose Due Date',
                        validation: 'Task Due Date is Required'),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TaskyButton(
                        onButtonPressed: () => cubit.addTask(),
                        horizontalPadding: 0.0,
                        content: const Text(
                          'Add Task',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
