// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, prefer_typing_uninitialized_variables, unused_element, must_be_immutable, unused_field, avoid_unnecessary_containers, unused_local_variable, sized_box_for_whitespace
import 'package:clear_to_do/materials/add_list_componenets.dart';
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

class MainScreenFirebase extends StatefulWidget {
  static const String id = 'mainScreenFirebaseFirebase';

  @override
  _MainScreenFirebaseState createState() => _MainScreenFirebaseState();
}

class _MainScreenFirebaseState extends State<MainScreenFirebase> {
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
                          }).addItem();

                      // await addTitle(userGeneratedValue).then((value) {
                      //   setState(() {
                      //     isVisible = (isVisible) ? false : true;
                      //   });
                      // });
                    },
                    title: 'Create new item',
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: ListStreams(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  /*
      Unused
          Future<void> addTitle(String userGeneratedValue) async {
            CollectionReference fireStore =
                FirebaseFirestore.instance.collection('collection');

            var generatedId = await fireStore
                .add({'title': userGeneratedValue, 'id': '', 'isDone': false});

            fireStore
                .doc(generatedId.id)
                .update({'id': generatedId.id}).then((value) => print('added '));
          }
  */
}

//stream list
class ListStreams extends StatefulWidget {
  @override
  State<ListStreams> createState() => _ListStreamsState();
}

class _ListStreamsState extends State<ListStreams> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseFirestore
          .collection('collection')
          .orderBy('id', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<dynamic> incompletedLists = [];
          List<dynamic> completedLists = [];

          var items = snapshot.data!.docs;
          for (var item in items) {
            if (item['isDone'] == false) {
              incompletedLists.add(item);
            } else {
              completedLists.add(item);
            }
          }

          List<dynamic> finalLists = [...incompletedLists, ...completedLists];

          return ReorderableListView.builder(
            onReorder: ((oldIndex, newIndex) => setState(() {
                  print('set state changed');
                })),
            itemCount: finalLists.length,
            itemBuilder: (context, index) {
              final item = finalLists[index];
              int len = finalLists.length;
              int fraction = 255 ~/ (len + 1);
              int val = (255 - (fraction * index));
              Color color = Color.fromRGBO((val), 0, 0, 1);
              String title = item['title'];
              print('item id: ${item.id.runtimeType}');
              return listTile(
                  item, color, index, context, title, item['isDone']);
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget listTile(item, Color color, int index, BuildContext context,
      String title, bool isDone) {
    return Dismissible(
      key: ValueKey(item.id),
      confirmDismiss: ((direction) async {
        if (direction == DismissDirection.startToEnd) {
          changeTaskStatus(item);
          return false;
        } else {
          deleteTask(item['id']);
          return true;
        }
      }),
      background: Container(
        color: Colors.green,
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10),
      ),
      secondaryBackground: Container(
        color: Colors.black,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Container(
        color: isDone ? Colors.grey[700] : color,
        // key: Key(index.toString()),
        child: ListTile(
          dense: true,
          selected: true,
          contentPadding: EdgeInsets.all(10),
          onTap: () {
            // Navigator.pushNamed(context, TaskList.id);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TaskList(
                  parentId: (item.id),
                ),
              ),
            );
          },
          title: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                decoration:
                    isDone ? TextDecoration.lineThrough : TextDecoration.none),
          ),
        ),
      ),
    );
  }

  //functions
  Future<void> deleteTask(doc) async {
    return _firebaseFirestore
        .collection('collection')
        .doc(doc)
        .delete()
        .then((value) => print('deleted'))
        .onError((error, stackTrace) => print(error));
  }

  void changeTaskStatus(item) async {
    bool status = true;
    if (item['isDone']) {
      status = false;
    }
    CollectionReference fireStore =
        FirebaseFirestore.instance.collection('collection');

    return await fireStore
        .doc(item.id)
        .update({'isDone': status}).then((value) => print('updated'));
  }
}
