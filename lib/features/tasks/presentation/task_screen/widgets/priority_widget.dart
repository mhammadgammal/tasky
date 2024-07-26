import 'package:flutter/material.dart';

class PriorityWidget extends StatelessWidget {
  const PriorityWidget(this.priority, this.priorityColor, {super.key});

  final String priority;
  final Color priorityColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.outlined_flag,
          size: 16.0,
          color: priorityColor,
        ),
        Text(
          priority,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 15.0,
            color: priorityColor,
          ),
        )
      ],
    );
  }
}
