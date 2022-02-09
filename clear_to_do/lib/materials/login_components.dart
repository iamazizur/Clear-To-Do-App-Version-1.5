// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import
import 'package:clear_to_do/screens/main_screen/main_screen.dart';
import 'package:clear_to_do/screens/main_screen/new_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:clear_to_do/materials/login_components.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            textStyle: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            Navigator.pushNamed(context, NewMainScreenFirebase.id);
          },
          child: Text('Get Started'),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Have an account?', style: TextStyle(fontSize: 20)),
            SizedBox(width: 10),
            InkWell(
              onTap: () {},
              child: Text('Log in',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ],
    );
  }
}

class AlreadyRegisterOrNotRegister extends StatelessWidget {
  final String title;
  final Function ontap;
  final String buttonTitle;

  const AlreadyRegisterOrNotRegister(
      {required this.title, required this.ontap, required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$title ',
            style: kDefaultTextStyle,
          ),
          InkWell(
            onTap: () {
              ontap();
            },
            child: Text(buttonTitle,
                style: kDefaultTextStyle.copyWith(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

const TextStyle kDefaultTextStyle = TextStyle(fontSize: 20);

class CustomButtonWithIcon extends StatelessWidget {
  final String title;
  final icon;
  final Function ontap;

  const CustomButtonWithIcon(
      {required this.title, required this.icon, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 70),
      child: ElevatedButton.icon(
        onPressed: () {
          ontap();
        },
        icon: FaIcon(icon),
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.lightBlueAccent,
          elevation: 1,
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class InputFieldCustom extends StatelessWidget {
  final String title;
  final icon;
  final Function onchange;
  final TextEditingController controllers;

  const InputFieldCustom(
      {required this.title,
      required this.icon,
      required this.onchange,
      required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 3,
        shadowColor: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(40),
        child: TextField(
          controller: controllers,
          onChanged: (value) {
            onchange();
          },
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            labelText: title,
            labelStyle: TextStyle(fontSize: 20),
            prefixIcon: Container(
              // padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              width: 60,
              height: 60,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(30)),
              child: FaIcon(
                icon,
                size: 30,
                color: Colors.white,
              ),
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.2),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }
}
