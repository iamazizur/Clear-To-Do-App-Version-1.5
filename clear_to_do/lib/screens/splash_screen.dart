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
  int updatedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          color: HexColor('#E9E3DE'),
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PageView.builder(
                  itemCount: splashScreenList.length,
                  onPageChanged: (index) {
                    setState(() {
                      updatedIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return splashScreenList[index];
                  }),
              // SizedBox(height: 10),
              newMethod(updatedIndex),
            ],
          ),
        ),
      ),
    );
  }

  Positioned newMethod(int updatedIndex) {
    return Positioned(
        bottom: 15,
        // width: double.infinity,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 1,
          alignment: Alignment.center,
          // color: Colors.amber,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: splashScreenList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(5),
                width: 15,
                // height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // borderRadius: BorderRadius.circular(10),
                  color:
                      (updatedIndex == index) ? Colors.white : Colors.white24,
                ),
              );
            },
          ),
        ));
  }
}

/*
Expanded(
                flex: 1,
                child: LoginComponent(),
              ),
*/

List<dynamic> splashScreenList = [
  SplashScreenFirst(),
  SplashScreenSecond(),
  SplashScreenThird(),
  SplashScreenFourth(),
  SplashScreenFifth(),
  SplashScreenSixth(),
  SplashScreenSeventh(),
];
