import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading(
      {super.key,
      this.baseColor = Colors.black,
      this.highlightColor = Colors.white,
      this.width,
      this.height});

  final Color baseColor;
  final Color highlightColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Container(
          width: width ?? double.infinity,
          height: height ?? double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.04),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
        ));
  }
}
