// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, prefer_typing_uninitialized_variables, unused_element, must_be_immutable, unused_field, avoid_unnecessary_containers, unused_local_variable, no_logic_in_create_state, todo, recursive_getters, override_on_non_overriding_member
import 'package:clear_to_do/materials/add_list_componenets.dart';
import 'package:clear_to_do/materials/delete_check_widget.dart';
import 'package:clear_to_do/model/models.dart';
import 'package:clear_to_do/screens/main_screen/main_sub_screen.dart';
import 'package:clear_to_do/screens/main_screen/task_list_firestore.dart';
import 'package:clear_to_do/utils/firestore_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../splashScreens/splash_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewTaskList extends StatefulWidget {
  NewTaskList({Key? key, required this.parentId}) : super(key: key);
  String parentId;
  static const String id = 'newTaskList';

  @override
  _NewTaskListState createState() => _NewTaskListState(parentId);
}

class _NewTaskListState extends State<NewTaskList> {
  String parentId;
  _NewTaskListState(this.parentId);
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    //collection reference :
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance
            .collection('collection')
            .doc(parentId)
            .collection('tasks');

    //firestorefunctions :
    FirestoreFunctions firestoreFunctions = FirestoreFunctions(
        collectionReference: FirebaseFirestore.instance
            .collection('collection')
            .doc(parentId)
            .collection('tasks'),
        map: {});

    //snapshot
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        collectionReference.snapshots();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _isVisible = (_isVisible) ? false : true;
            });
          },
          child: Column(
            children: [
              Visibility(
                visible: _isVisible,
                child: Expanded(
                  flex: 1,
                  child: AddListWidget(
                    buttonFunction: () async {
                      FirestoreFunctions(
                          collectionReference: collectionReference,
                          map: {
                            'id': '',
                            'title': userGeneratedValue,
                            'isDone': false
                          }).addItem().then((value) {
                        setState(() {
                          _isVisible = (_isVisible) ? false : true;
                        });
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
                  parentId: parentId,
                  firestoreFunctions: firestoreFunctions,
                  mainScreen: false,
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
