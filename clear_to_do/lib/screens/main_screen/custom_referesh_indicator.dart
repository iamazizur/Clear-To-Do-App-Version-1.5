// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, prefer_typing_uninitialized_variables, unused_element, must_be_immutable, unused_field, avoid_unnecessary_containers, unused_local_variable, sized_box_for_whitespace, prefer_final_fields
import 'dart:async';
import 'dart:ffi';

import 'package:clear_to_do/materials/add_list_componenets.dart';
import 'package:clear_to_do/materials/delete_check_widget.dart';
import 'package:clear_to_do/model/models.dart';
import 'package:clear_to_do/screens/main_screen/main_sub_screen.dart';
import 'package:clear_to_do/screens/main_screen/new_task_list.dart';
import 'package:clear_to_do/screens/main_screen/task_list_firestore.dart';
import 'package:clear_to_do/utils/firestore_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../splashScreens/splash_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CustomRefereshIndicator extends StatefulWidget {
  static const String id = 'CustomRefereshIndicatorFirebase';

  @override
  _CustomRefereshIndicatorState createState() =>
      _CustomRefereshIndicatorState();
}

class _CustomRefereshIndicatorState extends State<CustomRefereshIndicator> {
  IndicatorController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = IndicatorController(refreshEnabled: true);
  }

  Future<bool> fun() async {

    return Future.delayed(Duration(seconds: 5), () {
      print('fun');
      return true;
    });
  }

  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    var color = Colors.black;
    return Scaffold(
        body: SafeArea(
      child: CustomRefreshIndicator(
        loadingToIdleDuration: const Duration(seconds: 2),
        armedToLoadingDuration: const Duration(seconds: 2),
        draggingToIdleDuration: const Duration(seconds: 2),
        leadingGlowVisible: true,
        trailingGlowVisible: true,
        offsetToArmed: 200,
        controller: _controller,
        extentPercentageToArmed: 0.1,
        onRefresh: () async {
          
          await fun();
        },
        child: ListView(
          children: [
            ElevatedButton(
                onPressed: () {
                  // handleTimeOut();
                },
                child: Text(
                  'controller state',
                  style: TextStyle(fontSize: 20),
                )),
            
          ],
        ),
        builder: (context, child, controller) {
          return Stack(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                color: Colors.amber,
                child: AddListWidget(
                  buttonFunction: () {},
                  title: 'Add data',
                ),
              ),
              AnimatedBuilder(
                  animation: _controller!,
                  builder: (context, snapshot) {
                    return Transform.translate(
                      // angle: 10 * _controller!.value,
                      offset: Offset(0.0, 100 * _controller!.value),
                      child: child,
                    );
                  }),
            ],
          );
        },
      ),
    ));
  }
}
