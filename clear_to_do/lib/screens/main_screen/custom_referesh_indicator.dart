// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, prefer_typing_uninitialized_variables, unused_element, must_be_immutable, unused_field, avoid_unnecessary_containers, unused_local_variable, sized_box_for_whitespace
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
  final _helper = IndicatorStateHelper();
  ScrollDirection prevScrollDirection = ScrollDirection.forward;
  IndicatorController controller = IndicatorController(refreshEnabled: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = IndicatorController(refreshEnabled: true);
    controller.isComplete;
  }

  @override
  Widget build(BuildContext context) {
    var color = Colors.black;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: CustomRefreshIndicator(
          controller: controller,
          offsetToArmed: 200.0,
          completeStateDuration: const Duration(seconds: 2),
          loadingToIdleDuration: const Duration(seconds: 1),
          armedToLoadingDuration: const Duration(seconds: 1),
          draggingToIdleDuration: const Duration(seconds: 1),
          leadingGlowVisible: true,
          trailingGlowVisible: false,
          onRefresh: () => Future.delayed(const Duration(seconds: 3)),
          child: Container(
            alignment: Alignment.center,
            height: 300,
            child: Text(
              'data',
              style: TextStyle(fontSize: 40),
            ),
          ),
          /*
          ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.symmetric(vertical: 10),
              color: Colors.amber,
              child: Text('Azizur'),
            ),
          ),
          */
          builder: (
            BuildContext context,
            Widget child,
            IndicatorController controller,
          ) {
            if (_helper.didStateChange(from: controller.state)) {
              print('object');
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                (controller.isIdle) ? Text('isIdle') : Text('is-Not-Idle'),
                Container(
                  height: 100,
                  color: Colors.amber,
                  child: Center(
                    child: Text(
                      "NOT ARMED",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  width: double.infinity,
                  height: 50,
                  color: Colors.greenAccent,
                  child: Center(
                    child: Text(
                      "ARMED",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, snapshot) {
                    return Transform.translate(
                      offset: Offset(0.0, 100 * controller.value),
                      child: child,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
