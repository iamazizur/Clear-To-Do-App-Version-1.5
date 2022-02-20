// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import

import 'dart:ui';

import 'package:clear_to_do/unused_files/login_components.dart';
import 'package:clear_to_do/unused_files/main_screen.dart';
import 'package:clear_to_do/unused_files/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Signup extends StatefulWidget {
  static const String id = 'signUpPage';

  @override
  _SignupState createState() => _SignupState();
}

FirebaseAuth _auth = FirebaseAuth.instance;

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordControll = TextEditingController();
  TextEditingController usernameControll = TextEditingController();
  String name = '';
  String email = '';
  String password = '';

  void createAccount() async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(user.additionalUserInfo);

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
    Size size = MediaQuery.of(context).size;
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
                  controllers: usernameControll,
                  title: 'Name',
                  icon: FontAwesomeIcons.user,
                  onchange: () {
                    setState(() {
                      name = usernameControll.text;
                      // print('name : $name');
                    });
                  },
                ),
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
              title: 'Register',
              ontap: () {
                createAccount();
              },
            ),
            AlreadyRegisterOrNotRegister(
              title: 'Already registered?',
              buttonTitle: 'Log in',
              ontap: () {
                Navigator.pushNamed(context, SignInScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}


// String getName(TextEditingController nameController) {
//   print(nameController.value.text);
//   print('name : $name');
//   return nameController.value.text;
// }

// class UserInputValueGetter {
//   late String value;

//   set setvalue(String value) {
//     value = value;
//   }

//   String get getvalue {
//     return value;
//   }
// }

// class UserItems {
//   String name = '';
//   // set setName(String value) {
//   //   name = value;
//   // }

//   // String get getName {
//   //   return name;
//   // }
// }


/*
UserInputValueGetter userInputValueGetter =
                new UserInputValueGetter();
            userInputValueGetter.setEmail = value;
            var x = userInputValueGetter.getEmail;
            print(x);
*/







/*
// Creating Class named Gfg
class Gfg {
// Creating a Field/Property
late String geekName;

// Creating the getter method
// to get input from Field/Property
String get getName {
	return geekName;
}

// Creating the setter method
// to set the input in Field/Property
set setName(String name) {
	geekName = name;
}
}

void main() {
// Creating Instance of class
Gfg geek = Gfg();

// Calling the set_name method(setter method we created)
// To set the value in Property "geekName"
geek.setName = "GeeksForGeeks";

// Calling the get_name method(getter method we created)
// To get the value from Property "geekName"
print("Welcome to ${geek.getName}");
}

*/
