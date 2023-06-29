import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobapp/configs/ui_configs.dart';

class AppScreen extends StatelessWidget {
  Widget child;

  AppScreen({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   sh
        //   systemOverlayStyle: const SystemUiOverlayStyle(
        //     statusBarColor: ColorsConfigs.white,
        //     statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        //     statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        //   ),
        // ),
        body: SafeArea(
          child: child,
        ),
      ),
    );
  }
}
