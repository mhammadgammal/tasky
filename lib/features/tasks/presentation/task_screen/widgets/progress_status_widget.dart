import 'package:flutter/material.dart';

class ProgressStatusWidget extends StatelessWidget {
  const ProgressStatusWidget(this.status, this.statusColors, {super.key});

  final String status;
  final (Color, Color) statusColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 5.0, vertical: 3.0),
      decoration: BoxDecoration(
          color: statusColors.$2, borderRadius: BorderRadius.circular(10.0)),
      child: Text(
        status,
        style: TextStyle(color: statusColors.$1),
      ),
    );
  }
}
