// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, prefer_typing_uninitialized_variables, unused_element, must_be_immutable, unused_field, avoid_unnecessary_containers, unused_local_variable, sized_box_for_whitespace
import 'package:clear_to_do/materials/add_list_componenets.dart';
import 'package:clear_to_do/materials/delete_check_widget.dart';
import 'package:clear_to_do/model/models.dart';
import 'package:clear_to_do/unused_files/main_sub_screen.dart';
import 'package:clear_to_do/screens/main_screen/new_task_list.dart';
import 'package:clear_to_do/unused_files/task_list_firestore.dart';
import 'package:clear_to_do/utils/firestore_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        collectionReference.snapshots();
    // var color = Colors.black;
    return Scaffold(
      backgroundColor: Colors.black,
      // resizeToAvoidBottomInset: false,
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

                          String title = finalLists[index]['title'];
                          bool isDone = finalLists[index]['isDone'];
                          final FocusNode focusNode = FocusNode();
                          final TextEditingController textEditingController =
                              TextEditingController(text: title);
                          final String id = finalLists[index]['id'];

                          return NewWidget(
                              key: ValueKey(id),
                              id: id,
                              firestoreFunctions: firestoreFunctions,
                              item: item,
                              isDone: isDone,
                              color: color,
                              textEditingController: textEditingController,
                              focusNode: focusNode);
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
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
  NewWidget(
      {required this.id,
      required this.firestoreFunctions,
      required this.item,
      required this.isDone,
      required this.color,
      required this.textEditingController,
      required this.focusNode,
      required this.key});

  final String id;
  final FirestoreFunctions firestoreFunctions;
  final item;
  final bool isDone;
  final Color color;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final Key key;

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  FocusNode focusnode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(widget.id),
      child: Dismissible(
        key: ValueKey(widget.id),
        confirmDismiss: ((direction) async {
          return widget.firestoreFunctions.dismissable(direction, widget.item);
        }),
        background: DeleteOrCheck.checkContainer,
        secondaryBackground: DeleteOrCheck.deleteContainer,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NewTaskList(
                  parentId: (widget.item.id),
                ),
              ),
            );
          },
          child: Container(
            color: widget.isDone ? Colors.grey[700] : widget.color,
            padding: EdgeInsets.only(left: 15),
            width: MediaQuery.of(context).size.width * 1,
            alignment: Alignment.centerLeft,
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  child: EditableText(
                    onSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                      FirebaseFirestore.instance
                          .collection('collection')
                          .doc(widget.id)
                          .update({
                        'title': widget.textEditingController.text
                      }).then((value) {
                        print('successfully change');
                        setState(() {});
                      });
                    },
                    controller: widget.textEditingController,
                    focusNode: focusnode,
                    style: GoogleFonts.quicksand(
                        fontSize: 30,
                        color: Colors.white,
                        decoration: (widget.isDone)
                            ? TextDecoration.lineThrough
                            : null),
                    cursorColor: Colors.black,
                    backgroundCursorColor: Colors.black,
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
ListStreams(
                  collectionReference: collectionReference,
                  parentId: '',
                  firestoreFunctions: firestoreFunctions,
                  mainScreen: true,
                  ontap: () {},
                ),
*/
