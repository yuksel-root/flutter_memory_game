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
    Future.delayed(const Duration(seconds: 1)).then((value) {
      splashProv.setOpacity();
    });
    return Stack(children: [
      const Image(
        image: AssetImage(GameImgConstants.splashBg),
        fit: BoxFit.fill,
        alignment: Alignment.center,
      ),
      Scaffold(
        backgroundColor: const Color(0xFFffe7ba),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 1),
                Expanded(
                  flex: 10,
                  child: buildAnimatedOpacity(splashProv, context),
                ),
                const Spacer(flex: 5),
                Expanded(
                  flex: 10,
                  child: buildIndicator(context),
                ),
                Expanded(
                  flex: 5,
                  child: buildRowMessage(context),
                ),
              ]),
        ),
      ),
    ]);
  }

  Center buildRowMessage(BuildContext context) {
    return Center(
      child: GradientWidget(
          gradient: const LinearGradient(colors: [
            Color(0xFF9400D3),
            Color(0xFF00bfff),
          ]),
          widget: Center(
            child: Text(
              textAlign: TextAlign.center,
              "   Loading...    ",
              style: TextStyle(
                fontSize: context.dynamicH(0.008) * context.dynamicW(0.014),
              ),
            ),
          )),
    );
  }

  LottieCustomWidget buildIndicator(BuildContext context) {
    return LottieCustomWidget(
      width: context.dynamicW(0.8),
      height: context.dynamicH(0.28571),
      path: AppConstants.colorful_indicator,
    );
  }

  AnimatedOpacity buildAnimatedOpacity(
      SplashViewModel splashProv, BuildContext context) {
    return AnimatedOpacity(
      opacity: splashProv.getOpacity,
      duration: const Duration(seconds: 2),
      child: LottieCustomWidget(
        width: context.dynamicW(1),
        height: context.dynamicH(0.71428),
        path: AppConstants.hamster_json,
      ),
    );
  }
}
