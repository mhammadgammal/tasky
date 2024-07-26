import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky/core/theme/app_color.dart';

import 'default_form_field.dart';

// ignore: must_be_immutable
class DatePicker extends StatelessWidget {
  DatePicker(
      {super.key,
      required this.datePickerController,
      required this.datePickerLabel,
      required this.validation,
      this.labelColor = Colors.black,
      this.iconColor = AppColor.mainColor,
      this.dateColor = Colors.black});

  TextEditingController datePickerController;
  final String datePickerLabel;
  final String? validation;
  final Color labelColor;
  final Color iconColor;
  final Color dateColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.parse('2030-12-31'),
      ).then((value) => //DateFormat.yMMMMd().format(value!)
          datePickerController.text = DateFormat('yyyy-MM-dd').format(value!)),
      child: DefaultFormFiled(
          controller: datePickerController,
          inputType: TextInputType.datetime,
          fieldLabel: datePickerLabel,
          labelColor: labelColor,
          isEnabled: false,
          maxLines: 1,
          textFieldTextColor: dateColor,
          icon: null,
          suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.calendar_today,
                color: iconColor,
              )),
          validate: (value) =>
              value == null || value.isEmpty ? validation : null),
    );
  }
}
