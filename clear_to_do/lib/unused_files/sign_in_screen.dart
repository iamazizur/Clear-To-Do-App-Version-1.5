// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, unused_field, prefer_final_fields
import 'package:clear_to_do/unused_files/login_components.dart';
import 'package:clear_to_do/unused_files/main_screen.dart';
import 'package:clear_to_do/unused_files/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatefulWidget {
  static const String id = 'signInScreen';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordControll = TextEditingController();
  TextEditingController usernameControll = TextEditingController();
  String name = '';
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        print('no active user');
      } else {
        print(user.email);
        Navigator.pushNamed(context, MainScreen.id);
      }
    });
  }
  /*
  FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
  */

  void signin() async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      print('success');
      emailController.clear();
      passwordControll.clear();
      usernameControll.clear();
      Navigator.pushNamed(context, MainScreen.id);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InputFieldCustom(
                    title: 'Email',
                    icon: FontAwesomeIcons.envelope,
                    onchange: () {
                      email = emailController.text;
                      // print('email : $email');
                    },
                    controllers: emailController),
                InputFieldCustom(
                    title: 'Password',
                    icon: FontAwesomeIcons.key,
                    onchange: () {
                      password = passwordControll.text;
                      // print('password : $password');
                    },
                    controllers: passwordControll)
              ],
            ),
            SizedBox(height: 10),
            CustomButtonWithIcon(
              icon: FontAwesomeIcons.userPlus,
              title: 'Login',
              ontap: () {
                signin();
              },
            ),
            AlreadyRegisterOrNotRegister(
              title: 'Not yet registered?',
              buttonTitle: 'Sign up',
              ontap: () {
                Navigator.pushNamed(context, Signup.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
