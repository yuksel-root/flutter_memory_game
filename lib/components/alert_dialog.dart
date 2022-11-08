import 'dart:ui';
import 'package:flutter/material.dart';

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
          title: Text(
            title,
            maxLines: 1,
            style: const TextStyle(
                fontSize: 20,
                fontFamily: "Greycliff CF Bold",
                color: Colors.black),
          ),
          content: Text(
            content,
            maxLines: 3,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: "Greycliff CF Medium",
                color: Colors.black),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
                animationDuration: const Duration(milliseconds: 1000),
              ),
              child: const FittedBox(
                child: Text(
                  "Tamam",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Greycliff CF Bold",
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
