// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, prefer_typing_uninitialized_variables, unused_element, must_be_immutable, unused_field, avoid_unnecessary_containers, unused_local_variable, no_logic_in_create_state, todo, recursive_getters, override_on_non_overriding_member
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

class TaskList extends StatefulWidget {
  static const String id = 'TaskList';
  final String parentId;

  const TaskList({Key? key, required this.parentId}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState(parentId);
}

class _TaskListState extends State<TaskList> {
  _TaskListState(this.parentId);

  // Object? get parentId => parentId;
  String parentId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(parentId);
  }

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
                    addTaskList(userGeneratedValue);
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

  Future<void> addTaskList(String userGeneratedValue) async {
    CollectionReference firestore =
        FirebaseFirestore.instance.collection('collection');

    var generatedId = await firestore
        .doc(parentId)
        .collection('tasks')
        .add({'task': userGeneratedValue, 'id': ''});

    firestore
        .doc(parentId)
        .collection('tasks')
        .doc(generatedId.id)
        .update({'task': userGeneratedValue, 'id': generatedId.id}).then(
            (value) => print('successfully add taks'));
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
          print(snapshot.data?.docs.length);

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
