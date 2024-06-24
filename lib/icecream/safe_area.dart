import 'package:flutter/material.dart';
import 'package:ui_app/icecream/home_view.dart';

class SafeAreaWidget extends StatelessWidget {
  const SafeAreaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
      child: IceCreamView(),
    ));
  }
}
