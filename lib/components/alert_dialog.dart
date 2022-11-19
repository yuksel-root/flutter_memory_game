import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';

class AlertView extends StatelessWidget {
  final String title;
  final String content;
  final Function continueFunction;

  const AlertView(
      {Key? key,
      required this.title,
      required this.content,
      required this.continueFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1), //add blur
        child: AlertDialog(
          backgroundColor: Colors.white,
          title: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              title,
              maxLines: 1,
              style: TextStyle(
                  fontSize: context.dynamicHeight(0.005) *
                      context.dynamicWidth(0.008), //4*4 16px
                  fontFamily: "Greycliff CF Bold",
                  color: Colors.black),
            ),
          ),
          content: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              content,
              maxLines: 3,
              style: TextStyle(
                  fontSize: context.dynamicHeight(0.005) *
                      context.dynamicWidth(0.008), //4*4 16px
                  fontFamily: "Greycliff CF Medium",
                  color: Colors.black),
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.dynamicHeight(0.005) *
                  context.dynamicWidth(0.008))), //4*4 16px
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
                animationDuration: const Duration(milliseconds: 1000),
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  "Restart",
                  style: TextStyle(
                      fontSize: context.dynamicHeight(0.005) *
                          context.dynamicWidth(0.008), //4*4 16px
                      fontFamily: "Greycliff CF Bold",
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
              onPressed: () {
                continueFunction();
              },
            ),
          ],
        ));
  }
}
