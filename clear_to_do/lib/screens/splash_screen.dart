// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:clear_to_do/materials/login_components.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'splashScreens/splash_screens.dart';
// E9E3DE

class SplashScreen extends StatefulWidget {
  static const String id = 'splashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          color: HexColor('#E9E3DE'),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 6,
                child: PageView.builder(
                    itemCount: splashScreenList.length,
                    itemBuilder: (context, index) {
                      return splashScreenList[index];
                    }),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 1,
                child: LoginComponent(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



List<dynamic> splashScreenList = [
  SplashScreenFirst(),
  SplashScreenSecond(),
  SplashScreenThird(),
  SplashScreenFourth(),
  SplashScreenFifth(),
  SplashScreenSixth(),
  SplashScreenSeventh(),
];
