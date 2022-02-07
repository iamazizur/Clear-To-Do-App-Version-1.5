// ignore: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore, unused_import, avoid_print

import 'package:clear_to_do/model/models.dart';
import 'package:clear_to_do/screens/main_screen/main_sub_screen.dart';
import 'package:clear_to_do/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class RoutGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/mainSubScreen':
        subList = args;
        
        return MaterialPageRoute(
            builder: (context) => MainSubScreen(list: args));

      default:
        return MaterialPageRoute(builder: (context) => SplashScreen());
    }
  }
}
