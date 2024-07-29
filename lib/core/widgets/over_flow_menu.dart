import 'package:flutter/material.dart';
import 'package:tasky/core/router/app_navigator.dart';
import 'package:tasky/core/widgets/delete_dailogue.dart';

class OverFlowMenu extends StatelessWidget {
  const OverFlowMenu(
      {super.key, required this.taskId, required this.deleteTaskCallBack});
  final String taskId;
  final dynamic Function(String) deleteTaskCallBack;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.more_vert,
        size: 30.0,
        color: Colors.black,
      ),
      onSelected: (String item) {
        // Handle the selected item here
        switch (item) {
          case 'Edit':
            // Handle edit action
            print('edit task');
            AppNavigator.navigateToTaskDetails(context, taskId);
            break;
          case 'Delete':
            // Handle delete action
            showDialog(
                context: context,
                builder: (context) =>
                    DeleteDialogue(taskId, onYesPressed: () {
                      deleteTaskCallBack(taskId);
                      Navigator.pop(context);
                    }, onNoPressed: () {
                      Navigator.pop(context);
                    }));
    
            print('delete task');
            break;
          // Add more cases for other menu items
        }
      },
      itemBuilder: (BuildContext context) {
        return {'Edit', 'Delete'}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(
              choice,
              style: choice == 'Delete'
                  ? const TextStyle(color: Color(0xFFFF7D53))
                  : null,
            ),
          );
        }).toList();
      },
    );
  }
}
