// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors,

import 'package:clear_to_do/screens/main_screen/new_main_screen.dart';
import 'package:clear_to_do/screens/main_screen/new_task_list.dart';
import 'package:clear_to_do/screens/main_screen/settings.dart';
import 'package:flutter/material.dart';
import 'screens/splashScreens/splash_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ClearToDo());
}

class ClearToDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.black,
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Clear To Do',
      initialRoute: NewMainScreenFirebase.id,
      routes: {
        NewTaskList.id: (context) => NewTaskList(parentId: ""),
        NewMainScreenFirebase.id: (context) => NewMainScreenFirebase(),
        SplashScreen.id: (context) => SplashScreen(),
        Settings.id: (context) => Settings()
      },
    );
  }
}
