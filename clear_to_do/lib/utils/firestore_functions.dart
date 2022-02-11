// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, prefer_typing_uninitialized_variables, unused_element, must_be_immutable, unused_field, avoid_unnecessary_containers, unused_local_variable, sized_box_for_whitespace, non_constant_identifier_names, no_logic_in_create_state, curly_braces_in_flow_control_structures
import 'package:clear_to_do/materials/add_list_componenets.dart';
import 'package:clear_to_do/materials/delete_check_widget.dart';
import 'package:clear_to_do/screens/dismissable.dart';
import 'package:clear_to_do/screens/main_screen/new_task_list.dart';
import 'package:clear_to_do/screens/main_screen/task_list_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:marquee/marquee.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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

  Future<void> updateUserValue(dynamic item, String updatedValue) async {
    collectionReference.doc(item.id).update({'title': updatedValue}).then(
        (value) => print('User Value changed'));
  }

  void swapTasks(dynamic oldTask, dynamic newTask) {
    if (oldTask['isDone'] == true || newTask['isDone'] == true)
      return;
    else {
      String oldTitle = oldTask['title'];
      String newTitle = newTask['title'];
      String tempTitle = oldTask['title'];

      collectionReference
          .doc(oldTask.id)
          .update({'title': newTitle}).then((value) => print(newTitle));
      collectionReference
          .doc(newTask.id)
          .update({'title': tempTitle}).then((value) => print(tempTitle));
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
      _ListStreamsState(parentId, collectionReference, mainScreen, ontap);
}

class _ListStreamsState extends State<ListStreams> {
  final String parentId;
  final bool mainScreen;
  final Function ontap;

  final CollectionReference<Map<String, dynamic>> collectionReference;

  _ListStreamsState(
      this.parentId, this.collectionReference, this.mainScreen, this.ontap);

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
            dragStartBehavior: DragStartBehavior.start,
            onReorder: ((oldIndex, newIndex) async {
              final finalIndex = newIndex > oldIndex ? newIndex - 1 : newIndex;
              // if (newIndex >= finalLists.length)
              //   newIndex = finalLists.length - 1;
              // if (newIndex == oldIndex + 1) newIndex--;

              // if (newIndex < 0) newIndex = 0;
              print('oldIndex : $oldIndex');
              print('newIndex : $finalIndex');

              firestoreFunctions.swapTasks(
                  finalLists[oldIndex], finalLists[finalIndex]);
            }),
            itemCount: finalLists.length,
            itemBuilder: (context, index) {
              final item = finalLists[index];
              int len = finalLists.length;
              int fraction = 255 ~/ (len);
              int val = (255 - (fraction * index));
              Color colorRed = Color.fromRGBO((val), 0, 0, 1);
              Color colorBlue = Color.fromRGBO(0, 0, (val), 1);
              Color color = mainScreen ? colorRed : colorBlue;
              String title = item['title'];

              return listTile(item, color, index, context, title,
                  item['isDone'], firestoreFunctions, () {}, mainScreen);
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
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = title;

    return Dismissible(
      key: ValueKey(item.id),
      confirmDismiss: ((direction) async {
        return firestoreFunctions.dismissable(direction, item);
      }),
      background: DeleteOrCheck.checkContainer,
      secondaryBackground: DeleteOrCheck.deleteContainer,
      child: InkWell(
        onTap: () {
          if (mainScreen) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NewTaskList(
                  parentId: (item.id),
                ),
              ),
            );
          } else {
            return;
          }
        },
        child: Container(
          color: isDone ? Colors.grey[700] : color,
          padding: EdgeInsets.only(left: 15),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.1,
                child: (title.length < 15)
                    ? Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            decoration: isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      )
                    : Marquee(
                        showFadingOnlyWhenScrolling: true,
                        startAfter: Duration(seconds: 5),
                        pauseAfterRound: Duration(seconds: 5),
                        fadingEdgeEndFraction: 0.3,
                        blankSpace: 100,
                        velocity: 50,
                        text: title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            decoration: isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
  // marquee
    /*
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        decoration: isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  */
                /*
                  Marquee(
                      showFadingOnlyWhenScrolling: true,
                      startAfter: Duration(seconds: 5),
                      pauseAfterRound: Duration(seconds: 2),
                      fadingEdgeEndFraction: 0.3,
                      blankSpace: 100,
                      velocity: 50,
                      text: title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          decoration: isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none)),
                */
    /*


    
    return InkWell(
      onTap: () {
        if (mainScreen) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewTaskList(
                parentId: (item.id),
              ),
            ),
          );
        } else {
          return;
        }
      },
      key: ValueKey(item['id']),
      child: Slidable(
        startActionPane: ActionPane(motion: ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) => firestoreFunctions.changeTaskStatus(item),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.check,
            label: 'Done',
          ),
          SlidableAction(
            onPressed: null,
            backgroundColor: Colors.blue.shade900,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ]),
        endActionPane: ActionPane(motion: ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) async =>
                await firestoreFunctions.deleteItem(item.id),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ]),
        key: ValueKey(item.id),
        child: Container(
          padding: EdgeInsets.all(20),
          color: isDone ? Colors.grey[700] : color,
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // color: Colors.green,
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.1,
                child: (title.length < 15)
                    ? Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            decoration: isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      )
                    : Marquee(
                        showFadingOnlyWhenScrolling: true,
                        startAfter: Duration(seconds: 5),
                        pauseAfterRound: Duration(seconds: 5),
                        fadingEdgeEndFraction: 0.3,
                        blankSpace: 100,
                        velocity: 50,
                        text: title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            decoration: isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none)),

                /*
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      decoration: isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
                */
                /*
                Marquee(
                    showFadingOnlyWhenScrolling: true,
                    startAfter: Duration(seconds: 5),
                    pauseAfterRound: Duration(seconds: 2),
                    fadingEdgeEndFraction: 0.3,
                    blankSpace: 100,
                    velocity: 50,
                    text: title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        decoration: isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none)),
              */
              ),
              Icon(
                Icons.drag_indicator_sharp,
                color: Colors.white,
              ),
            ],
          ),
          /*
          ListTile(
            horizontalTitleGap: 30,
            contentPadding: EdgeInsets.all(10),
            leading: Icon(Icons.edgesensor_high),
            onTap: () {
              if (mainScreen) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewTaskList(
                      parentId: (item.id),
                    ),
                  ),
                );
              } else {
                return;
              }
            },
            trailing: Icon(
              Icons.drag_indicator_sharp,
              color: Colors.white,
            ),
            title: EditableText(
              paintCursorAboveText: true,
              showCursor: true,
              onSubmitted: (value) =>
                  firestoreFunctions.updateUserValue(item, value),
              controller: textEditingController,
              focusNode: FocusNode(),
              cursorColor: Colors.yellow,
              backgroundCursorColor: Colors.green,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  decoration: isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
              autofocus: false,
            ),
          ),
          */
        ),
      ),
    );
  
    */
*/
/*
 // Widget listTile(
  //     dynamic item,
  //     Color color,
  //     int index,
  //     BuildContext context,
  //     String title,
  //     bool isDone,
  //     FirestoreFunctions firestoreFunctions,
  //     Function ontap,
  //     bool mainScreen) {
  //   bool editIcon = false;
  //   return Dismissible(
  //     key: ValueKey(item.id),
  //     confirmDismiss: ((direction) async {
  //       return firestoreFunctions.dismissable(direction, item);
  //     }),
  //     background: DeleteOrCheck.checkContainer,
  //     secondaryBackground: DeleteOrCheck.deleteContainer,
  //     child: Container(
  //       color: isDone ? Colors.grey[700] : color,
  //       alignment: Alignment.topCenter,
  //       child: ListTile(
  //           contentPadding: mainScreen ? EdgeInsets.all(10) : null,
  //           onTap: () {
  //             if (mainScreen) {
  //               Navigator.of(context).push(
  //                 MaterialPageRoute(
  //                   builder: (context) => NewTaskList(
  //                     parentId: (item.id),
  //                   ),
  //                 ),
  //               );
  //             } else {
  //               return;
  //             }
  //           },
  //           trailing: mainScreen
  //               ? null
  //               : Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Icon(
  //                       Icons.drag_indicator_sharp,
  //                       color: Colors.white,
  //                     ),
  //                   ],
  //                 ),
  //           title: mainScreen
  //               ? Text(
  //                   title,
  //                   style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 25,
  //                       decoration: isDone
  //                           ? TextDecoration.lineThrough
  //                           : TextDecoration.none),
  //                 )
  //               : TextField(
  //                   decoration: InputDecoration(
  //                       hintText: title,
  //                       hintStyle: TextStyle(
  //                         color: Colors.white,
  //                         fontSize: 25,
  //                       ),
  //                       border:
  //                           OutlineInputBorder(borderSide: BorderSide.none)),
  //                 )),
  //     ),
  //   );
  // }
*/