// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, prefer_typing_uninitialized_variables, unused_element, must_be_immutable, unused_field, avoid_unnecessary_containers, unused_local_variable, sized_box_for_whitespace, non_constant_identifier_names, no_logic_in_create_state
import 'package:clear_to_do/materials/add_list_componenets.dart';
import 'package:clear_to_do/materials/delete_check_widget.dart';
import 'package:clear_to_do/screens/dismissable.dart';
import 'package:clear_to_do/screens/main_screen/new_task_list.dart';
import 'package:clear_to_do/screens/main_screen/task_list_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirestoreFunctions {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference collectionReference;
  // final String value;

  // final String collectionId;
  var map;

  FirestoreFunctions({required this.collectionReference, this.map});

  Future<void> addItem() async {
    var generatedId = await collectionReference.add(map);

    collectionReference
        .doc(generatedId.id)
        .update({'id': generatedId.id}).then((value) => print('SUCCESS!'));
  }

  Future<void> deleteItem(String id) async {
    collectionReference
        .doc(id)
        .delete()
        .then((value) => print('Successfully Deleted'))
        .onError((error, stackTrace) => print(error));
  }

  Future<void> changeTaskStatus(dynamic item) async {
    bool status = (item['isDone']) ? false : true;
    collectionReference
        .doc(item.id)
        .update({'isDone': status}).then((value) => print('updated'));
  }

  List<dynamic> generateList(dynamic items) {
    List<dynamic> incompletedLists = [];
    List<dynamic> completedLists = [];

    for (var item in items) {
      if (item['isDone'] == false) {
        incompletedLists.add(item);
      } else {
        completedLists.add(item);
      }
    }

    List<dynamic> finalLists = [...incompletedLists, ...completedLists];
    return finalLists;
  }

  Future<bool?> dismissable(DismissDirection direction, dynamic item) async {
    if (direction == DismissDirection.startToEnd) {
      FirestoreFunctions(collectionReference: collectionReference, map: {})
          .changeTaskStatus(item);
      return false;
    } else {
      FirestoreFunctions(collectionReference: collectionReference, map: {})
          .deleteItem(item['id']);
      return true;
    }
  }
}

//liststreams class

class ListStreams extends StatefulWidget {
  var parentId;
  final bool mainScreen;

  CollectionReference<Map<String, dynamic>> collectionReference;
  FirestoreFunctions firestoreFunctions;
  Function ontap;
  ListStreams(
      {this.parentId,
      required this.collectionReference,
      required this.firestoreFunctions,
      required this.ontap,
      required this.mainScreen});
  @override
  State<ListStreams> createState() =>
      _ListStreamsState(parentId, collectionReference, mainScreen);
}

class _ListStreamsState extends State<ListStreams> {
  final String parentId;
  final bool mainScreen;

  final CollectionReference<Map<String, dynamic>> collectionReference;

  _ListStreamsState(this.parentId, this.collectionReference, this.mainScreen);

  @override
  Widget build(BuildContext context) {
    //onTap function

    //snapshot
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        collectionReference.snapshots();

    //collection reference
    FirestoreFunctions firestoreFunctions = FirestoreFunctions(
      collectionReference: collectionReference,
    );

    return StreamBuilder<QuerySnapshot>(
      stream: snapshot,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var items = snapshot.data!.docs;

          List<dynamic> finalLists = firestoreFunctions.generateList(items);

          return ReorderableListView.builder(
            onReorder: ((oldIndex, newIndex) => setState(() {
                  print('set state changed');
                })),
            itemCount: finalLists.length,
            itemBuilder: (context, index) {
              final item = finalLists[index];
              int len = finalLists.length;
              int fraction = 255 ~/ (len);
              int val = (255 - (fraction * index));
              Color color = Color.fromRGBO((val), 0, 0, 1);
              String title = item['title'];

              return listTile(item, color, index, context, title,
                  item['isDone'], firestoreFunctions, () {
                print('azizur rahman');
              }, mainScreen);
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget listTile(
      dynamic item,
      Color color,
      int index,
      BuildContext context,
      String title,
      bool isDone,
      FirestoreFunctions firestoreFunctions,
      Function ontap,
      bool mainScreen) {
    return Dismissible(
      key: ValueKey(item.id),
      confirmDismiss: ((direction) async {
        return firestoreFunctions.dismissable(direction, item);
      }),
      background: DeleteOrCheck.checkContainer,
      secondaryBackground: DeleteOrCheck.deleteContainer,
      child: Container(
        color: isDone ? Colors.grey[700] : color,
        child: ListTile(
          contentPadding: EdgeInsets.all(10),
          onTap: () {
            if (mainScreen) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TaskList(
                    parentId: (item.id),
                  ),
                ),
              );
            } else {
              return;
            }
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
}
