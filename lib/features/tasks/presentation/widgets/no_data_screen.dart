import 'package:flutter/material.dart';

class NoTasksScreen extends StatelessWidget {
  const NoTasksScreen(this.selectedItem, {super.key});
  final int selectedItem;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_getNoDataText(selectedItem)),
    );
  }

  String _getNoDataText(int selectedItem) {
    switch (selectedItem) {
      case 0:
        return 'No Tasks Yet';
      case 1:
        return 'You have no in progress tasks';
      case 2:
        return 'You have no waiting tasks';
      case 3:
        return 'You have no finished tasks';
      default:
        return 'No Tasks Yet';
    }
  }
}
