import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/custom_app_bar.dart';
import 'package:flutter_memory_game/components/custom_column_box.dart';
import 'package:flutter_memory_game/components/custom_elevated_button.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';
import 'package:flutter_memory_game/core/constants/app_colors.dart';
import 'package:flutter_memory_game/core/constants/navigation_constants.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';
import 'package:flutter_memory_game/core/navigation/navigation_service.dart';
import 'package:flutter_memory_game/view_model/game_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LevelsView extends StatelessWidget {
  const LevelsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationService _navigation;
    _navigation = NavigationService.instance;
    final gameViewProv = Provider.of<GameViewModel>(context);
    return scaffoldWidget(context, gameViewProv, _navigation);
  }

  Scaffold scaffoldWidget(
    BuildContext context,
    GameViewModel gameViewProv,
    NavigationService _navigation,
  ) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(
        dynamicPreferredSize: context.dynamicH(0.15),
        appBar: gameAppBarWidget(context, gameViewProv, _navigation),
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
            ),
          ),
          child: Center(
            child: Container(
              child: SizedBox(
                height: context.mediaQuery.size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(flex: 1),
                    expandedCardWidget(context, gameViewProv, _navigation),
                    const Spacer(flex: 1),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar gameAppBarWidget(
    BuildContext context,
    GameViewModel gameViewProv,
    NavigationService _navigation,
  ) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      flexibleSpace: flexibleAppBarWidgets(context, gameViewProv, _navigation),
    );
  }

  FittedBox flexibleAppBarWidgets(
    BuildContext context,
    GameViewModel gameProv,
    NavigationService _navigation,
  ) {
    return FittedBox(
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: context.dynamicH(0.4),
            children: [
              elevatedBtn(
                context,
                Icons.arrow_back_rounded,
                gameProv,
                _navigation,
              ),
              SizedBox(),
            ],
          ),
          Wrap(
            children: [
              gradientStarWidget(
                context,
                context.dynamicW(0.01) * context.dynamicH(0.01),
              ),
              gradientText(
                context,
                " 1 / 100",
                context.dynamicW(0.01) * context.dynamicH(0.01),
                LinearGradient(colors: AppColors.rainBowColors),
              ),
            ],
            alignment: WrapAlignment.spaceEvenly,
          ),
        ],
      ),
    );
  }

  Expanded expandedCardWidget(
    BuildContext context,
    GameViewModel gameViewProv,
    NavigationService navigation,
  ) {
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
        padding: EdgeInsets.all(
          //3*3 4px
          context.dynamicH(0.004) * context.dynamicW(0.006),
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: levelBox(context, gameViewProv, index, navigation),
          );
        },
      ),
    );
  }

  FittedBox levelBox(
    BuildContext context,
    GameViewModel gameProv,
    int index,
    NavigationService navigation,
  ) {
    final cPadding = EdgeInsets.all(
      context.dynamicH(0.0028) * context.dynamicW(0.004),
    );
    return FittedBox(
      child: CustomColumnBox(
        clickFunction: () {
          navigation.navigateToPageClear(
            path: NavigationConstants.gameView,
            data: [],
          );
        },
        cPadding: cPadding,
        bgGradient: LinearGradient(
          colors: [Colors.deepPurple, Color(0xff6dd5ed)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        columnChild1: GradientWidget(
          gradient: const SweepGradient(colors: AppColors.fakeRainbowColors),
          widget: gradientText(
            context,
            (index + 1).toString(),
            context.dynamicW(0.01) * context.dynamicH(0.01),
            LinearGradient(
              colors: [Colors.deepPurple, Color(0xff6dd5ed)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        columnChild2: gradientThreeStarXd(
          context,
          context.dynamicW(0.01) * context.dynamicH(0.01),
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
        colors: AppColors.rainBowColors,
        center: Alignment(0.0, 0.5),
        tileMode: TileMode.clamp,
      ),

      widget: Icon(Icons.star, size: starIconSize),
    );
  }

  GradientWidget gradientText(
    BuildContext context,
    String text,
    double fontSize,
    Gradient gradient,
  ) {
    return GradientWidget(
      gradient: gradient,
      widget: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: text, style: GoogleFonts.bungeeSpice()),
          ],
          style: TextStyle(
            fontSize: fontSize,
            letterSpacing: 1,
            shadows: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 5,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomBtn elevatedBtn(
    BuildContext context,
    IconData icon,
    GameViewModel gameProv,
    NavigationService _navigation,
  ) {
    return CustomBtn(
      borderRadius: BorderRadius.circular(
        context.dynamicH(0.01) * context.dynamicW(0.014),
      ),
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
            Colors.cyanAccent,
          ],
          startAngle: 0.9,
          endAngle: 6.0,
          tileMode: TileMode.clamp,
        ),
        widget: Icon(
          icon,
          size: context.dynamicH(0.01) * context.dynamicW(0.01),
        ),
      ),
      onPressFunc: () {
        _navigation.navigateToPageClear(
          path: NavigationConstants.homeView,
          data: [],
        );
      },
    );
  }
}
