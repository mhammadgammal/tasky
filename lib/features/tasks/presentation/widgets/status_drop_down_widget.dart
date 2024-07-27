import 'package:flutter/material.dart';

import '../../../../core/theme/app_color.dart';

class StatusDropDownWidget extends StatelessWidget {
  const StatusDropDownWidget(
      {super.key,
      required this.status,
      required this.selectedStatus,
      required this.onStatusChanged});

  final List<String> status;
  final String selectedStatus;
  final void Function(String?) onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        value: selectedStatus,
        // menuMaxHeight: 100.0,
        iconEnabledColor: AppColor.mainColor,
        iconSize: 24.0,
        selectedItemBuilder: (context) => status
            .map((e) => Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 15.0, vertical: 0.0),
                  // Increased vertical padding
                  child: Text(
                    selectedStatus,
                    style: const TextStyle(
                        color: AppColor.mainColor, fontSize: 20.0),
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
            status.length,
            (index) => DropdownMenuItem<String>(
                value: status[index],
                child: SizedBox(child: Text(status[index])))),
        onChanged: onStatusChanged);
  }
}
