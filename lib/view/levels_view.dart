import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/custom_app_bar.dart';
import 'package:flutter_memory_game/components/custom_column_box.dart';
import 'package:flutter_memory_game/components/custom_elevated_button.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';
import 'package:flutter_memory_game/view_model/game_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LevelsView extends StatelessWidget {
  const LevelsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameViewProv = Provider.of<GameViewModel>(context);
    return scaffoldWidget(context, gameViewProv);
  }

  Scaffold scaffoldWidget(
    BuildContext context,
    GameViewModel gameViewProv,
  ) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          dynamicPreferredSize: context.dynamicH(0.15),
          appBar: gameAppBarWidget(
            context,
            gameViewProv,
          ),
        ),
        body: AnimatedOpacity(
          opacity: 1,
          curve: Curves.elasticInOut,
          duration: const Duration(microseconds: 200),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/game_bg_jpeg/bg0.jpeg"),
              fit: BoxFit.cover,
            )),
            child: Center(
              child: Container(
                child: SizedBox(
                  height: context.mediaQuery.size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(flex: 1),
                      expandedCardWidget(context, gameViewProv),
                      const Spacer(flex: 1),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  AppBar gameAppBarWidget(BuildContext context, GameViewModel gameViewProv) {
    return AppBar(
      flexibleSpace: flexibleAppBarWidgets(context, gameViewProv),
    );
  }

  FittedBox flexibleAppBarWidgets(
    BuildContext context,
    gameViewProv,
  ) {
    return FittedBox(
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: context.dynamicH(0.4),
            children: [
              elevatedBtn(context, Icons.arrow_back_rounded),
              SizedBox(),
            ],
          ),
          Wrap(children: [
            gradientStarWidget(
              context,
              context.dynamicW(0.01) * context.dynamicH(0.01),
            ),
            gradientText(
              context,
              " 1 / 100",
              context.dynamicW(0.01) * context.dynamicH(0.01),
              LinearGradient(
                colors: [
                  Colors.deepPurple,
                  Color(0xff6dd5ed),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            )
          ], alignment: WrapAlignment.spaceEvenly),
        ],
      ),
    );
  }

  Expanded expandedCardWidget(
      BuildContext context, GameViewModel gameViewProv) {
    return Expanded(
      flex: 100,
      child: GridView.builder(
        itemCount: 40,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: context.dynamicW(0.02), //10px
          mainAxisSpacing: context.dynamicH(0.01428), //10px
          childAspectRatio: 1 / 1,
        ),
        padding: EdgeInsets.all(//3*3 4px
            context.dynamicH(0.004) * context.dynamicW(0.006)),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {},
              child: levelBox(
                context,
                gameViewProv,
                index,
              ));
        },
      ),
    );
  }

  FittedBox levelBox(BuildContext context, GameViewModel gameProv, int index) {
    final cPadding =
        EdgeInsets.all(context.dynamicH(0.0028) * context.dynamicW(0.004));
    return FittedBox(
      child: CustomColumnBox(
        clickFunction: () {},
        cPadding: cPadding,
        bgGradient: LinearGradient(
          colors: [
            Colors.deepPurple,
            Color(0xff6dd5ed),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
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
          widget: gradientText(
            context,
            "1",
            context.dynamicW(0.01) * context.dynamicH(0.01),
            LinearGradient(
              colors: [
                Colors.deepPurple,
                Color(0xff6dd5ed),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        columnChild2: GradientWidget(
          gradient: const SweepGradient(colors: [
            Color(0xff4D5B5B),
            Color(0xff5E6C6C),
          ]),
          widget: gradientThreeStarXd(
            context,
            context.dynamicW(0.01) * context.dynamicH(0.01),
          ),
        ),
      ),
    );
  }

  Wrap gradientThreeStarXd(BuildContext context, double starIconSize) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      spacing: context.dynamicW(0.004),
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

  GradientWidget gradientText(
      BuildContext context, String text, double fontSize, Gradient gradient) {
    return GradientWidget(
      gradient: gradient,
      widget: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: text,
              style: GoogleFonts.bungeeSpice(),
            ),
          ],
          style: TextStyle(fontSize: fontSize, letterSpacing: 1, shadows: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 5,
              offset: Offset(1, 1),
            )
          ]),
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
            Icon(icon, size: context.dynamicH(0.01) * context.dynamicW(0.01)),
      ),
      onPressFunc: () {},
    );
  }
}
