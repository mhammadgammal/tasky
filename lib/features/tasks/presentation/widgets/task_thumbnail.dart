import 'package:flutter/material.dart';
import 'package:tasky/core/utils/api_utils/api_end_points.dart';

class TaskThumbnail extends StatelessWidget {
  const TaskThumbnail(
      {super.key,
      required this.ifImageExist,
      required this.imagePath,
      this.thumbnailSize});

  final bool ifImageExist;
  final String imagePath;
  final double? thumbnailSize;

  @override
  Widget build(BuildContext context) {
    return Image.network('${ApiEndPoints.baseUrl}images/$imagePath',
        width: thumbnailSize ?? 50.0,
        height: thumbnailSize ?? 56.0, loadingBuilder: (BuildContext context,
            Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
        );
      }
    }, errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
      return const SizedBox(
        width: 50.0,
        height: 56.0,
        child: Icon(
          size: 50.0,
          Icons.error,
          color: Colors.red,
        ),
      );
    });
  }
}
