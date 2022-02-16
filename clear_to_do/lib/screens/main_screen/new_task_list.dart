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

List<Color> colorsList = [
  Colors.red.shade800,
  Colors.orange.shade900,
  Colors.orange.shade800,
  Colors.orange.shade700,
  Colors.orange.shade600,
  Colors.orange.shade500,
  Colors.orange.shade400,
  Colors.orange.shade300,
];

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
                child: StreamBuilder<QuerySnapshot>(
                  stream: snapshot,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var items = snapshot.data!.docs;

                      List<dynamic> finalLists =
                          firestoreFunctions.generateList(items);
                      return ReorderableListView.builder(
                        onReorder: ((oldIndex, newIndex) async {
                          final finalIndex =
                              newIndex > oldIndex ? newIndex - 1 : newIndex;

                          firestoreFunctions.swapTasks(
                              finalLists[oldIndex], finalLists[finalIndex]);
                        }),
                        itemCount: finalLists.length,
                        itemBuilder: (context, index) {
                          int colorIndex = index;
                          if (colorIndex >= finalLists.length) {
                            colorIndex = finalLists.length - 1;
                          }
                          Color color = colorsList[colorIndex];
                          final item = finalLists[index];
                          int len = finalLists.length;

                          String title = item['title'];
                          // bool visibility = addReminderVisibility[index];
                          bool isDone = item['isDone'];
                          return NewWidget(
                            item: item,
                            firestoreFunctions: firestoreFunctions,
                            isDone: isDone,
                            color: color,
                            title: title,
                            key: ValueKey(item['id']),
                          );
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget(
      {required this.item,
      required this.firestoreFunctions,
      required this.isDone,
      required this.color,
      required this.title,
      required this.key});

  final item;
  final FirestoreFunctions firestoreFunctions;
  final bool isDone;
  final Color color;
  final String title;
  final Key key;

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  bool visibility = false;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.item.id),
      confirmDismiss: ((direction) async {
        return widget.firestoreFunctions.dismissable(direction, widget.item);
      }),
      background: DeleteOrCheck.checkContainer,
      secondaryBackground: DeleteOrCheck.deleteContainer,
      child: InkWell(
        onTap: () {
          setState(() {
            if (visibility) {
              visibility = false;
            } else {
              visibility = true;
            }
          });
        },
        child: Container(
          color: widget.isDone ? Colors.grey[700] : widget.color,
          padding: EdgeInsets.only(left: 15),
          width: MediaQuery.of(context).size.width * 1,
          alignment: Alignment.centerLeft,
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              Visibility(
                visible: visibility,
                child: InkWell(
                  
                  child: Text(
                    'Add reminder',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
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
*/