import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/custom_dialog.dart';

class TestView extends StatelessWidget {
  //flutter pub run flutter_native_splash:create

//flutter build apk --target-platform android-arm --analyze-size

//flutter build appbundle --target-platform android-arm

//flutter build apk --split-per-abi
  const TestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const CustomAlertDialog();
                },
              );
            },
          ),
        ));
  }
}
