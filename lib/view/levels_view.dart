import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/custom_app_bar.dart';
import 'package:flutter_memory_game/components/custom_column_box.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';
import 'package:flutter_memory_game/view_model/game_view_model.dart';
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
          opacity: gameViewProv.getOpacity,
          curve: Curves.elasticInOut,
          duration: const Duration(microseconds: 200),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(gameViewProv.getBgImages),
              fit: BoxFit.cover,
            )),
            height: context.mediaQuery.size.height,
            width: context.mediaQuery.size.width,
            child: Center(
              child: SingleChildScrollView(
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
      child: Wrap(children: [
        gradientStarWidget(context, 20),
        Text(
          " 1 / 100 ",
          style: TextStyle(fontSize: 20),
        ),
      ], alignment: WrapAlignment.spaceEvenly),
    );
  }

  FittedBox expandedCardWidget(
      BuildContext context, GameViewModel gameViewProv) {
    return FittedBox(
      child: GridView.builder(
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: context.dynamicW(0.02), //10px
          mainAxisSpacing: context.dynamicH(0.014), //10px
          childAspectRatio: 1 / 1,
        ),
        padding: EdgeInsets.all(//3*3 4px
            context.dynamicH(0.004) * context.dynamicW(0.006)),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: TweenAnimationBuilder(
              tween:
                  Tween<double>(begin: 0, end: gameViewProv.getAngleArr(index)),
              duration: const Duration(milliseconds: 650),
              builder: (BuildContext context, double val, __) {
                return Transform(
                  transform: Matrix4.rotationY(val)..setEntry(3, 2, 0.01),
                  alignment: Alignment.center,
                  child: levelBoxContainer(context, gameViewProv, index),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Container levelBoxContainer(
      BuildContext context, GameViewModel gameViewProv, int index) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple,
            Color(0xff6dd5ed),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            spreadRadius: 0.5,
            offset: Offset(0, 1),
          ),
        ],
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
              context.dynamicH(0.005) * context.dynamicW(0.008)),
          bottomRight: Radius.circular(
              context.dynamicH(0.005) * context.dynamicW(0.008)),
        ),
      ),
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
