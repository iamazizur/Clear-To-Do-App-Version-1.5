// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, prefer_typing_uninitialized_variables, unused_element, must_be_immutable, unused_field, avoid_unnecessary_containers, unused_local_variable, sized_box_for_whitespace
import 'package:clear_to_do/materials/add_list_componenets.dart';
import 'package:clear_to_do/model/models.dart';
import 'package:clear_to_do/screens/main_screen/main_sub_screen.dart';
import 'package:clear_to_do/screens/main_screen/task_list_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../splashScreens/splash_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreenFirebase extends StatefulWidget {
  static const String id = 'mainScreenFirebaseFirebase';

  @override
  _MainScreenFirebaseState createState() => _MainScreenFirebaseState();
}

FirebaseFirestore _tasks = FirebaseFirestore.instance;

class _MainScreenFirebaseState extends State<MainScreenFirebase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: AddListWidget(
                buttonFunction: () {
                  print('button clicked');
                  print(userGeneratedValue);
                  addTitle(userGeneratedValue);
                },
                title: 'Create new item',
              ),
            ),
            Expanded(flex: 8, child: StreamsLists()),
          ],
        ),
      ),
    );
  }

  Future<void> addTitle(String userGeneratedValue) {
    CollectionReference fireStore =
        FirebaseFirestore.instance.collection('collection');

    return fireStore.add({'title': userGeneratedValue});
  }
}

//stream list
class StreamsLists extends StatefulWidget {
  @override
  State<StreamsLists> createState() => _StreamsListsState();
}

class _StreamsListsState extends State<StreamsLists> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseFirestore.collection('collection').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            // itemCount: list.length,
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              int len = snapshot.data!.docs.length;

              int fraction = 255 ~/ (len + 1);

              int val = (255 - (fraction * index));
              if (val < 1) print(val);
              String title = snapshot.data?.docs[index]['title'];
              return Container(
                color: Color.fromRGBO((val), 0, 0, 1),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  onLongPress: () async {
                    print(snapshot.data?.docs[index]['title']);
                    deleteTask(snapshot.data?.docs[index].id);
                  },
                  onTap: () {
                    // Navigator.pushNamed(context, TaskList.id);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TaskList(
                          parentId: (snapshot.data!.docs[index].id),
                        ),
                      ),
                    );
                  },
                  title: Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              );
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<void> deleteTask(doc) async {
    return _firebaseFirestore
        .collection('collection')
        .doc(doc)
        .delete()
        .then((value) => print('deleted'))
        .onError((error, stackTrace) => print(error));
  }
}
