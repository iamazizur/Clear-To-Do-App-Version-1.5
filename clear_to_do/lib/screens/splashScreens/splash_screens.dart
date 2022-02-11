// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:clear_to_do/screens/main_screen/new_main_screen.dart';
import 'package:clear_to_do/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

//splash screen 1
class SplashScreenFirst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Tasks Todo',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: HexColor('#E60965')),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: RichText(
            text: TextSpan(
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                      text: 'Swipe ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'to begin'),
                ]),
          ),
        ),
      ],
    );
  }
}

//splash screen 2

class SplashScreenSecond extends StatelessWidget {
  const SplashScreenSecond({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Clear sorts items by Priority',
                  style: TextStyle(
                      fontSize: 25,
                      color: HexColor('#E60965'),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Important items are highlighted at the top',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Image(image: AssetImage('assets/images/splashImage1.png'))),
        Divider(),
      ],
    );
  }
}

//splash screen 3

class SplashScreenThird extends StatelessWidget {
// color: HexColor('#E60965'),
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Text(
                  'Tap and hold',
                  style: TextStyle(
                    color: HexColor('#E60965'),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  'to pick an item up. Drag it up or down to change its priority',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Image(image: AssetImage('assets/images/splashImage2.png'))),
        Divider(),
      ],
    );
  }
}

//splash screen 4
class SplashScreenFourth extends StatelessWidget {
// color: HexColor('#E60965'),
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Text(
              'There are three navigation levels...',
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Image(image: AssetImage('assets/images/splashImage3.png'))),
        Divider(),
      ],
    );
  }
}

//splash screen 5
class SplashScreenFifth extends StatelessWidget {
// color: HexColor('#E60965'),
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Text(
              'Pinch together vertically to collapse your current level and navigate up.',
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Image(image: AssetImage('assets/images/splashImage4.png'))),
        Divider(),
      ],
    );
  }
}

//splash screen 6
class SplashScreenSixth extends StatelessWidget {
// color: HexColor('#E60965'),
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: GoogleFonts.quicksand(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      height: 1.5),
                  children: [
                    TextSpan(
                      text: 'Tap on a list',
                      style: GoogleFonts.quicksand(
                          color: HexColor('#E60965'),
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(text: ' to see its content'),
                    TextSpan(text: '\n'),
                    TextSpan(
                      text: 'Tap on a list title',
                      style: TextStyle(
                          color: HexColor('#E60965'),
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(text: ' to edit it..'),
                  ]),
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Image(image: AssetImage('assets/images/splashImage4.png'))),
        Divider(),
      ],
    );
  }
}

//splash screen 7
class SplashScreenSeventh extends StatelessWidget {
// color: HexColor('#E60965'),
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Are you ready?',
          style: TextStyle(fontSize: 25),
        ),
        Text(
          'Make sure you understand',
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ConfirmationButtons(
              primary: 'Yes,',
              secondary: 'I got it',
              onpress: () {
                Navigator.pushNamed(context, NewMainScreenFirebase.id);
              },
            ),
            ConfirmationButtons(
              primary: 'No,',
              secondary: 'I want to see tutorial',
              onpress: () {
                Navigator.pushNamed(context, SplashScreen.id);
              },
            ),
          ],
        )
      ],
    );
  }
}

class ConfirmationButtons extends StatelessWidget {
  final String primary;
  final String secondary;
  final Function onpress;

  ConfirmationButtons(
      {required this.primary, required this.secondary, required this.onpress});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(),
          )
          //   RoundedRectangleBorder(
          // borderRadius: BorderRadius.circular(50),

          ),
      onPressed: () => onpress(),
      child: Column(
        children: [
          Text(
            primary,
            style: TextStyle(fontSize: 35, color: Colors.black),
          ),
          Text(
            secondary,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
