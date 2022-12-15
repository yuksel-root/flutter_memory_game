import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.mediaQuery.size.height;
    final screenWidth = context.mediaQuery.size.width;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: containerTitleContentWidget(screenWidth),
                ),
                Expanded(
                  child: Container(
                      color: Colors.red,
                      width: screenWidth / 1.5,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.blue,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: columnFirstContentWidget(context),
                                  ),
                                  Expanded(
                                    child: columnSecondContentWidget(context),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: rowButtonsThirdContentWidget(context),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container containerTitleContentWidget(double screenWidth) {
    return Container(
      width: screenWidth / 1.5,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        color: Colors.indigo,
      ),
      child: const Center(
        child: Icon(
          Icons.error_outline_outlined,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  Row rowButtonsThirdContentWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: alertBtn1(context)),
        Expanded(child: alertBtn1(context)),
        Expanded(child: alertBtn1(context)),
      ],
    );
  }

  Column columnFirstContentWidget(BuildContext context) {
    return Column(children: [
      gradientThreeStarXd(
        context,
        context.dynamicH(0.01) * context.dynamicW(0.014),
      ),
      const Text("OPEN"),
      const Text("4"),
      const GradientWidget(
          gradient: LinearGradient(colors: [Colors.white, Colors.yellow]),
          widget: Icon(Icons.star)),
      const Text("4"),
    ]);
  }

  Column columnSecondContentWidget(BuildContext context) {
    return Column(children: [
      Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: gradientThreeStarXd(
                context, context.dynamicH(0.008) * context.dynamicW(0.012)),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Text("open : 5 "),
          ),
        ],
      ),
      Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: gradientTwoStarXd(
                context, context.dynamicH(0.008) * context.dynamicW(0.012)),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Text("open : 7 "),
          ),
        ],
      ),
      Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: gradientStarWidget(
                context, context.dynamicH(0.008) * context.dynamicW(0.012)),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Text("open : - "),
          ),
        ],
      ),
    ]);
  }

  ElevatedButton alertBtn1(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.transparent;
            }
            if (states.contains(MaterialState.pressed)) {
              return Colors.transparent;
            }
            return null;
          },
        ),
      ),
      onPressed: () {},
      // ignore: prefer_const_constructors
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: context.dynamicH(0.01),
          horizontal: context.dynamicW(0.014),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.withOpacity(0.5),
              Colors.deepPurpleAccent.withOpacity(0.5),
              Colors.deepPurpleAccent.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(
              context.dynamicH(0.005) * context.dynamicW(0.008)),
        ),
        child: GradientWidget(
          gradient: const SweepGradient(
            colors: [
              Color(0xFF9400D3),
              Color(0xFF4B0082),
              Color(0xFF0000FF),
              Color(0xFF00FF00),
              Color(0xFFFFFF00),
              Color(0xFFFF7F00),
              Color(0xFFFF0000),
            ],
            startAngle: 0.9,
            endAngle: 6.0,
            tileMode: TileMode.clamp,
          ),
          widget: FittedBox(
            child: Column(
              children: [
                Icon(
                  Icons.menu,
                  size: context.dynamicH(0.01) * context.dynamicW(0.014),
                ),
                Text(
                  "MENU",
                  style: TextStyle(
                    fontSize: context.dynamicH(0.01) * context.dynamicW(0.014),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Wrap gradientThreeStarXd(BuildContext context, double starIconSize) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      spacing: 2,
      children: [
        gradientStarWidget(context, starIconSize),
        gradientStarWidget(context, starIconSize),
        gradientStarWidget(context, starIconSize),
      ],
    );
  }

  Wrap gradientTwoStarXd(BuildContext context, double starIconSize) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      spacing: 2,
      children: [
        gradientStarWidget(context, starIconSize),
        gradientStarWidget(context, starIconSize),
        gradientStarWidget(context, starIconSize),
      ],
    );
  }

  GradientWidget gradientStarWidget(BuildContext context, double starIconSize) {
    // ignore: prefer_const_constructors
    return GradientWidget(
      // ignore: prefer_const_constructors
      gradient: const RadialGradient(
        colors: [
          Color(0xFF9400D3),
          Color(0xFF4B0082),
          Color(0xFF0000FF),
          Color(0xFF00FF00),
          Color(0xFFFFFF00),
          Color(0xFFFF7F00),
          Color(0xFFFF0000),
        ],
        center: Alignment(0.0, 0.5),
        tileMode: TileMode.clamp,
      ),

      widget: Icon(
        Icons.star,
        size: starIconSize,
      ),
    );
  }
}
