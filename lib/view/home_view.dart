import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/custom_column_box.dart';
import 'package:flutter_memory_game/components/custom_elevated_button.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';
import 'package:flutter_memory_game/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

final _mainTxt1Clr = [
  Colors.cyanAccent,
  Colors.yellowAccent,
  Colors.pinkAccent,
  Colors.cyanAccent,
  Colors.pinkAccent,
  Colors.yellowAccent,
];

final _mainTxt2Clr = [
  Colors.cyanAccent,
  Colors.white,
  Colors.purpleAccent,
  Colors.cyanAccent,
  Colors.cyanAccent,
  Colors.white,
];

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProv = Provider.of<HomeViewModel>(context);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/home_bg_jpeg/main_bg.jpeg")),
      ),
      child: Column(
        children: [
          settingsButtonWidgets(context, homeProv),
          expandedMainTexts(context, 2),
          expandedModeBoxes(context, 4, homeProv),
        ],
      ),
    );
  }

  Expanded expandedMainTexts(
    BuildContext context,
    int flex,
  ) {
    return Expanded(
        flex: flex,
        child: Column(
          children: [
            Expanded(
                flex: 1, child: gradientText(context, _mainTxt1Clr, "MEMORY")),
            Expanded(
                flex: 1, child: gradientText(context, _mainTxt2Clr, "GAME")),
          ],
        ));
  }

  Expanded expandedModeBoxes(
      BuildContext context, int flex, HomeViewModel homeProv) {
    return Expanded(
      flex: flex,
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: context.dynamicW(0.2),
        children: [
          modeSelectBox(Icons.bar_chart_sharp, context, "Stage Mode", homeProv),
          modeSelectBox(
              Icons.access_alarms_rounded, context, "Arcade Mode", homeProv),
        ],
      ),
    );
  }

  FittedBox settingsButtonWidgets(
      BuildContext context, HomeViewModel homeProv) {
    return FittedBox(
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: context.dynamicW(0.65),
        children: [
          elevatedBtn(context, Icons.arrow_back_rounded),
          elevatedBtn(context, Icons.settings),
        ],
      ),
    );
  }

  CustomColumnBox modeSelectBox(IconData iconName, BuildContext context,
      String text, HomeViewModel homeProv) {
    final cPadding =
        EdgeInsets.all(context.dynamicH(0.004) * context.dynamicW(0.008));
    return CustomColumnBox(
      clickFunction: () {
        if (text == "Stage Mode") {
          homeProv.clickStageMode();
          print("stage");
        } else {
          homeProv.clickArcadeMode();
          print("arcade");
        }
      },
      cPadding: cPadding,
      bgGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xff00ffff).withOpacity(0.5),
          const Color(0xff00ffff).withOpacity(0.5),
        ],
      ),
      columnChild1: GradientWidget(
        gradient: const SweepGradient(
          colors: [
            Colors.cyanAccent,
            Colors.pinkAccent,
            Colors.yellowAccent,
            Colors.cyanAccent
          ],
        ),
        widget: Icon(
          iconName,
          size: context.dynamicH(0.0142) * context.dynamicW(0.02),
        ),
      ),
      columnChild2: GradientWidget(
        gradient: const SweepGradient(colors: [
          Color(0xff4D5B5B),
          Color(0xff5E6C6C),
        ]),
        widget: Text(
          text,
          style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: context.dynamicH(0.00571) * context.dynamicW(0.008),
              letterSpacing: 2),
        ),
      ),
    );
  }

  GradientWidget gradientText(
    BuildContext context,
    List<Color> colors,
    String text,
  ) {
    return GradientWidget(
      gradient: SweepGradient(
        colors: colors,
        stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
      ),
      widget: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 1,
        style: TextStyle(
          fontSize: context.dynamicH(0.01) * context.dynamicW(0.014),
          letterSpacing: 5,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  CustomBtn elevatedBtn(BuildContext context, IconData icon) {
    return CustomBtn(
      borderRadius: BorderRadius.circular(
          context.dynamicH(0.01) * context.dynamicW(0.014)),
      boxShadow: const [
        BoxShadow(
          color: Colors.transparent,
          blurRadius: 10,
          spreadRadius: 0.5,
          offset: Offset(0, 8),
        ),
      ],
      bgGradient: LinearGradient(
        colors: [
          Colors.deepPurpleAccent.withOpacity(0.5),
          Colors.deepPurple.withOpacity(0.5),
          Colors.deepPurpleAccent.withOpacity(0.5),
          Colors.deepPurpleAccent.withOpacity(0.5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: GradientWidget(
        gradient: const SweepGradient(
          colors: [
            Colors.cyanAccent,
            Colors.pinkAccent,
            Colors.yellowAccent,
            Colors.cyanAccent
          ],
          startAngle: 0.9,
          endAngle: 6.0,
          tileMode: TileMode.clamp,
        ),
        widget:
            Icon(icon, size: context.dynamicH(0.01) * context.dynamicW(0.014)),
      ),
      onPressFunc: () {},
    );
  }
}
