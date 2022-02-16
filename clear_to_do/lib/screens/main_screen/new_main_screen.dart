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

class NewMainScreenFirebase extends StatefulWidget {
  static const String id = 'NewMainScreenFirebaseFirebase';

  @override
  _NewMainScreenFirebaseState createState() => _NewMainScreenFirebaseState();
}

class _NewMainScreenFirebaseState extends State<NewMainScreenFirebase> {
  FirestoreFunctions firestoreFunctions = FirestoreFunctions(
      collectionReference: FirebaseFirestore.instance.collection('collection'));
  CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance.collection('collection');
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    var color = Colors.black;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              isVisible = (isVisible) ? false : true;
            });
          },
          child: Column(
            children: [
              Visibility(
                visible: isVisible,
                child: Expanded(
                  flex: 1,
                  child: AddListWidget(
                    buttonFunction: () async {
                      FirestoreFunctions(
                          collectionReference: FirebaseFirestore.instance
                              .collection('collection'),
                          map: {
                            'id': '',
                            'title': userGeneratedValue,
                            'isDone': false
                          }).addItem().then((value) {
                        setState(
                          () {
                            isVisible = (isVisible) ? false : true;
                          },
                        );
                      });
                    },
                    title: 'Create new item',
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: ListStreams(
                  collectionReference: collectionReference,
                  parentId: '',
                  firestoreFunctions: firestoreFunctions,
                  mainScreen: true,
                  ontap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}

