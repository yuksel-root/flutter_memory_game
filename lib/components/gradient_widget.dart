import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  const GradientWidget({
    Key? key,
    required this.gradient,
    required this.widget,
  }) : super(key: key);

  final Widget widget;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) => gradient
          .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: widget,
    );
  }
}
