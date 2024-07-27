import 'package:flutter/material.dart';

import '../../../../core/theme/app_color.dart';

class PriorityDropDownWidget extends StatelessWidget {
  const PriorityDropDownWidget(
      {super.key,
      required this.priorities,
      required this.selectedPriority,
      required this.onPriorityChanged});

  final List<String> priorities;
  final String selectedPriority;
  final void Function(String?) onPriorityChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        value: selectedPriority,
        iconEnabledColor: AppColor.mainColor,
        iconSize: 24.0,
        selectedItemBuilder: (context) => priorities
            .map((e) => Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 15.0),
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
                        '$selectedPriority Priority',
                        style: const TextStyle(
                            color: AppColor.mainColor, fontSize: 20.0),
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
            priorities.length,
            (index) => DropdownMenuItem<String>(
                value: priorities[index], child: Text(priorities[index]))),
        onChanged: onPriorityChanged);
  }
}
