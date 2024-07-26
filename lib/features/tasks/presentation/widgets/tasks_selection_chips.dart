import 'package:flutter/material.dart';
import 'package:tasky/core/theme/app_color.dart';

class TasksSelectionChips extends StatelessWidget {
  const TasksSelectionChips(
      {super.key,
      required this.chipsItems,
      required this.selectedTaskTypeIndex,
      required this.onChipPressed});

  final List<String> chipsItems;
  final int selectedTaskTypeIndex;
  final void Function(bool, int) onChipPressed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 10.0,
        children: List<Widget>.generate(chipsItems.length, (int index) {
          return ChoiceChip(
            label: Text(
              chipsItems[index],
              style: TextStyle(
                color: selectedTaskTypeIndex == index
                    ? Colors.white
                    : AppColor.solidGrey, // Conditional color
              ),
            ),
            selected: selectedTaskTypeIndex == index,
            selectedColor: AppColor.mainColor,
            backgroundColor: AppColor.unselectedChipColor,
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: const BorderSide(color: Colors.transparent),
            ),
            // side: const BorderSide(color: Colors.transparent),
            onSelected: (bool selected) => onChipPressed(selected, index),
          );
        }).toList());
  }
}
