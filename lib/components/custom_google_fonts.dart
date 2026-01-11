import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleFontsText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextStyle? styleOverride;
  final int? maxLines;
  final TextStyle Function({TextStyle? textStyle})? googleFont;

  const GoogleFontsText(
    this.text, {
    super.key,

    this.textAlign,
    this.maxLines,
    this.overflow,
    this.styleOverride,
    this.googleFont,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = (googleFont ?? GoogleFonts.bungeeSpice)(
      textStyle: styleOverride,
    );

    return RichText(
      text: TextSpan(text: text, style: textStyle),
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines ?? 1,
      overflow: overflow ?? TextOverflow.visible,
    );
  }
}
