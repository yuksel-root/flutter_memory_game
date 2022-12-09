import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/custom_lottie.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';
import 'package:flutter_memory_game/core/constants/app_constants.dart';
import 'package:flutter_memory_game/core/constants/game_img_constants.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';
import 'package:flutter_memory_game/view_model/splash_view_model.dart';
import 'package:provider/provider.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final splashProv = Provider.of<SplashViewModel>(context);
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      splashProv.setOpacity();
    });
    return Stack(children: [
      const Positioned.fill(
          child: Image(
        image: AssetImage(GameImgConstants.splashBg),
        fit: BoxFit.fill,
      )),
      Scaffold(
        backgroundColor: Color(0xFFffe7ba),
        body: Column(children: [
          const Spacer(flex: 1),
          Expanded(
            flex: 4,
            child: buildAnimatedOpacity(splashProv, context),
          ),
          Expanded(
            flex: 4,
            child: buildRowMessage(context),
          )
        ]),
      ),
    ]);
  }

  Center buildRowMessage(BuildContext context) {
    return Center(
      child: Column(children: [
        const GradientWidget(
            gradient: LinearGradient(colors: [
              Color(0xFFFF7F00),
              Color(0xFF9400D3),
              Color(0xFF00bfff),
              Color(0xFFFF7F00),
            ]),
            widget: Center(
              child: Text(
                textAlign: TextAlign.center,
                "Hello, How are you Today?",
                style: TextStyle(fontSize: 25),
              ),
            )),
        LottieCustomWidget(
          width: context.dynamicWidth(0.4),
          height: context.dynamicHeight(0.28571),
          path: AppConstants.colorful_indicator,
        )
      ]),
    );
  }

  Center buildAnimatedOpacity(
      SplashViewModel splashProv, BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        opacity: splashProv.getOpacity,
        duration: const Duration(seconds: 2),
        child: LottieCustomWidget(
          width: context.dynamicWidth(0.4),
          height: context.dynamicHeight(0.3571),
          path: AppConstants.hamster_json,
        ),
      ),
    );
  }
}
