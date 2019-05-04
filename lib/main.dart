import 'package:flutter/material.dart';
import 'package:upg_fisi/screens/home_page.dart';
import 'package:upg_fisi/app_constants.dart';

const PrimaryColor = const Color(0xFF06006D);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = ThemeData(
      fontFamily: "Roboto",
      primaryColor: AppConstants.primaryColor,
    );
    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: HomePage(),
    );
  }
}
