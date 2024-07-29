import 'dart:io';

import 'package:flutter/material.dart';

class TaskThumbnail extends StatelessWidget {
  const TaskThumbnail(
      {super.key,
      required this.ifImageExist,
      required this.imagePath,
      this.thumbnailSize = 50.0});

  final bool ifImageExist;
  final String imagePath;
  final double thumbnailSize;
  @override
  Widget build(BuildContext context) {
    return ifImageExist
        ? Image.file(
            File(imagePath),
            width: thumbnailSize,
            height: thumbnailSize,
            fit: BoxFit.cover,
          )
        : Icon(
            Icons.task,
            size: thumbnailSize,
          );
  }
}
