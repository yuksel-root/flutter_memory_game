import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieCustomWidget extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  const LottieCustomWidget(
      {Key? key, required this.path, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      fit: BoxFit.cover,
      height: height!,
      width: width!,
      "assets/animation_jsons/$path.json",
    );
  }
}
