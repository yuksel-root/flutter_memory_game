import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';

class CustomColumnBox extends StatelessWidget {
  final EdgeInsetsGeometry cPadding;
  final Gradient bgGradient;
  final Widget columnChild1;
  final Widget columnChild2;
  final Function clickFunction;

  const CustomColumnBox({
    Key? key,
    required this.cPadding,
    required this.bgGradient,
    required this.columnChild1,
    required this.columnChild2,
    required this.clickFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      elevation: 20,
      color: Colors.black,
      child: InkWell(
        onTap: () => {
          clickFunction(),
        },
        child: Transform(
          transform: Matrix4.identity()..setEntry(3, 2, 0.002),
          child: Container(
            padding: cPadding,
            child: Container(
              // ignore: sort_child_properties_last
              child: Container(
                padding: cPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: context.dynamicH(0.014),
                    ),
                    columnChild1,
                    SizedBox(
                      height: context.dynamicH(0.014),
                    ),
                    columnChild2,
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: const Color(0xff333333),
                borderRadius: BorderRadius.circular(10),
                gradient: bgGradient,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xff799BA7),
                    offset: Offset(10.0, 10.0),
                    blurRadius: 15,
                    spreadRadius: 0.0,
                  ),
                  BoxShadow(
                    color: Color(0xff769AB0),
                    offset: Offset(-10.0, -10.0),
                    blurRadius: 15,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
