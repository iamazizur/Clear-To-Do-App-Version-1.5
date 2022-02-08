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
  static const String id = 'NewTaskList';
  final String parentId;

  const NewTaskList({Key? key, required this.parentId}) : super(key: key);

  @override
  _NewTaskListState createState() => _NewTaskListState(parentId);
}

class _NewTaskListState extends State<NewTaskList> {
  _NewTaskListState(this.parentId);
  String parentId;

  Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
      FirebaseFirestore.instance.collection('collection').snapshots();

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
                  buttonFunction: () async {
                    FirestoreFunctions(
                        collectionReference: FirebaseFirestore.instance
                            .collection('collection')
                            .doc(parentId)
                            .collection('tasks'),
                        map: {
                          'id': '',
                          'task': userGeneratedValue,
                          'isDone': false
                        }).addItem();
                  },
                  title: 'Create tasks',
                )),
            Expanded(
              flex: 8,
              child: TasklListStreams(id: parentId),
            )
          ],
        ),
      ),
    );
  }
}

class TasklListStreams extends StatefulWidget {
  TasklListStreams({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<TasklListStreams> createState() => _TasklListStreamsState();
}

class _TasklListStreamsState extends State<TasklListStreams> {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firebaseFirestore
          .collection('collection')
          .doc(widget.id)
          .collection('tasks')
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

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              int val = (255 - (index * 30));
              if (val <= 0) val = 0;
              String title = snapshot.data?.docs[index]['task'];
              return Container(
                color: Color.fromRGBO(0, 0, (val), 1),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  title: Text(
                    snapshot.data!.docs[index]['task'],
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}


class ListStreams extends StatefulWidget {
  @override
  State<ListStreams> createState() => _ListStreamsState();
}

class _ListStreamsState extends State<ListStreams> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
      FirebaseFirestore.instance.collection('collection').snapshots();
  CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance.collection('collection');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: snapshot,
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
              int fraction = 255 ~/ (len);
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
          // changeTaskStatus(item);
          FirestoreFunctions(collectionReference: collectionReference, map: {})
              .changeTaskStatus(item);
          return false;
        } else {
          // deleteTask(item['id']);
          FirestoreFunctions(collectionReference: collectionReference, map: {})
              .deleteItem(item['id']);
          return true;
        }
      }),
      background: DeleteOrCheck.checkContainer,
      secondaryBackground: DeleteOrCheck.deleteContainer,
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
                builder: (context) => NewTaskList(
                  parentId: (item.id),
                ),
              ),

              // MaterialPageRoute(
              //   builder: (context) => TaskList(
              //     parentId: (item.id),
              //   ),
              // ),
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

  /*  
  Unused--
          Future<void> deleteTask(doc) async {
            return _firebaseFirestore
                .collection('collection')
                .doc(doc)
                .delete()
                .then((value) => print('deleted'))
                .onError((error, stackTrace) => print(error));
          }

  */

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
