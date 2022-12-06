import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/constants/game_img_constants.dart';
import 'package:flutter_memory_game/view_model/splash_view_model.dart';
import 'package:provider/provider.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final splashProv = Provider.of<SplashViewModel>(context);
    return buildStackScaffold(context, splashProv);
  }

  Widget buildStackScaffold(BuildContext context, SplashViewModel viewModel) {
    return Stack(children: [
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              buildCenterTextWelcome(context, viewModel),
              buildAnimatedAlignIcon(viewModel, context),
            ],
          ),
        ),
      ),
    ]);
  }

  Center buildCenterTextWelcome(
    BuildContext context,
    SplashViewModel viewModel,
  ) {
    return Center(
      child: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: viewModel.isFirstInit ? 0 : 1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              "Welcome",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            CircularProgressIndicator.adaptive()
          ],
        ),
      ),
    );
  }

  Widget buildAnimatedAlignIcon(
    SplashViewModel viewModel,
    BuildContext context,
  ) {
    return AnimatedAlign(
      alignment:
          viewModel.isFirstInit ? Alignment.center : Alignment.bottomCenter,
      duration: const Duration(seconds: 1),
      child: Image.asset(GameImgConstants.hiddenCardPng),
    );
  }
}
