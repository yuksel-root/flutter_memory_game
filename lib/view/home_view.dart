import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/main_bg_images/main_bg2.jpeg")),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: context.dynamicWidth(0.65),
                children: [
                  elevatedBtn(context, Icons.arrow_back_rounded),
                  elevatedBtn(context, Icons.settings),
                ],
              ),
            ),
            Expanded(flex: 2, child: gradientText()),
            Expanded(
                flex: 4,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: context.dynamicWidth(0.15),
                  children: [
                    modeSelectBox(
                        Icons.lock_clock_rounded, context, "Stage Mode"),
                    modeSelectBox(
                        Icons.lock_clock_rounded, context, "Arcade Mode"),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Container modeSelectBox(
      IconData iconName, BuildContext context, String text) {
    return Container(
      color: Colors.red,
      height: context.mediaQuery.size.height / 4,
      width: context.mediaQuery.size.height / 4,
      child: GradientWidget(
        gradient: const LinearGradient(colors: [
          Colors.green,
          Colors.blue,
        ]),
        widget: Stack(
          alignment: Alignment.center,
          children: [
            GradientWidget(
              gradient: const SweepGradient(
                colors: [
                  Colors.grey,
                  Colors.grey,
                ],
              ),
              widget: Icon(iconName),
            ),
            SizedBox(
              height: context.dynamicHeight(0.2),
            ),
            Text(
              text,
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }

  GradientWidget gradientText() {
    return const GradientWidget(
      gradient: LinearGradient(colors: [
        Colors.white,
        Colors.blue,
        Colors.purple,
        Colors.red,
        Colors.green,
      ]),
      widget: Text(
        "MEMORY  GAME",
        textAlign: TextAlign.center,
        maxLines: 2,
        style: TextStyle(
          fontSize: 50,
          letterSpacing: 5,
          wordSpacing: 5,
        ),
      ),
    );
  }

  ElevatedButton elevatedBtn(BuildContext context, IconData icon) {
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              context.dynamicHeight(0.01) * context.dynamicWidth(0.014)),
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.withOpacity(0.5),
              Colors.deepPurpleAccent.withOpacity(0.5),
              Colors.deepPurpleAccent.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GradientWidget(
          widget: Icon(
            icon,
            size: context.dynamicHeight(0.01) * context.dynamicWidth(0.014),
          ),
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
        ),
      ),
    );
  }
}
