import 'package:flutter/material.dart';
import 'package:tasky/core/utils/screen_utils/screen_util.dart';
import 'package:tasky/core/widgets/shimmer_loading.dart';

class TasksLoading extends StatelessWidget {
  const TasksLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        taskLoadingItem(context),
        taskLoadingItem(context),
        taskLoadingItem(context),
        taskLoadingItem(context),
        taskLoadingItem(context),
      ],
    );
  }

  Widget taskLoadingItem(context) => SizedBox(
        width: ScreenUtil.getScreenWidth(context),
        height: 100.0,
        child: const Padding(
          padding: EdgeInsetsDirectional.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30.0,
                child: ShimmerLoading(),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: SizedBox(
                  height: 100.0,
                  child: ShimmerLoading(),
                ),
              ),
            ],
          ),
        ),
      );
}
