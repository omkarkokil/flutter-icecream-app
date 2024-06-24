import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_app/icecream/safe_area.dart';

void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ice Cream",
      theme: ThemeData(
        fontFamily: GoogleFonts.dmSans().fontFamily,
      ),
      home: const SafeAreaWidget(),
    );
  }
}
