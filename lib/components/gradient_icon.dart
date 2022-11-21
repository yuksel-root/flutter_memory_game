import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';

class GradientIcon extends StatelessWidget {
  const GradientIcon(this.icon, this.dynamicHeight, this.dynamicWidth,
      {Key? key,
      required this.isIconGradient,
      required this.bgGradient,
      this.iconColor,
      required this.isbgGradient,
      required this.iconGradient})
      : super(key: key);

  final IconData icon;
  final double dynamicWidth;
  final double dynamicHeight;
  final Gradient? iconGradient;
  final Gradient? bgGradient;
  final bool isIconGradient;
  final bool isbgGradient;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return (isIconGradient == true || isbgGradient == false)
        ? ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds) => iconGradient!.createShader(bounds),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    context.dynamicHeight(dynamicHeight) *
                        context.dynamicWidth(dynamicWidth) /
                        2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.5),
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: context.dynamicHeight(dynamicHeight) *
                    context.dynamicWidth(dynamicWidth),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              gradient: bgGradient,
              borderRadius: BorderRadius.circular(
                  context.dynamicHeight(dynamicHeight) *
                      context.dynamicWidth(dynamicWidth)),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    context.dynamicHeight(dynamicHeight) *
                        context.dynamicWidth(dynamicWidth)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: context.dynamicHeight(dynamicHeight) *
                    context.dynamicWidth(dynamicWidth),
                color: iconColor,
              ),
            ),
          );
  }
}
