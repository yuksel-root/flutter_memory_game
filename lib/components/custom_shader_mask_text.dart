import 'package:flutter/material.dart';

class ShaderText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextStyle? textStyle;
  final int? maxLines;
  final Gradient gradient;

  const ShaderText(
    this.gradient,
    this.text,
    this.textAlign,
    this.overflow,
    this.textStyle,
    this.maxLines, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: textStyle),
    );
  }
}
