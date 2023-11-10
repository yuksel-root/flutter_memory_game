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
    return Center(
      child: Lottie.asset(
        fit: BoxFit.cover,
        height: height!,
        alignment: Alignment.center,
        width: width!,
        "assets/animations_json/$path.json",
      ),
    );
  }
}
