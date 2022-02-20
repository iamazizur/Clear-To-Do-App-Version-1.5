// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, unused_local_variable
import 'package:clear_to_do/materials/add_list_componenets.dart';
import 'package:clear_to_do/materials/delete_check_widget.dart';
import 'package:clear_to_do/model/models.dart';
import 'package:clear_to_do/unused_files/main_sub_screen.dart';
import 'package:clear_to_do/utils/routes_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../screens/splashScreens/splash_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'mainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController createListText = TextEditingController();
  String userListValue = '';

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: AddListWidget(
                title: 'Create a new list',
                buttonFunction: () {
                  setState(() {
                    int id = mainScreenList.last['id'] as int;
                    id++;
                    Map<String, Object> map = {
                      'title': userGeneratedValue,
                      'task': [],
                      'isDone': false,
                      'id': id,
                    };
                    mainScreenList.add(map);
                    print(map);
                  });
                },
              ),
            ),
            Expanded(
              flex: 8,
              child: ReorderableListView.builder(
                onReorder: (oldIndex, newIndex) {},
                itemCount: mainScreenList.length,
                itemBuilder: (context, index) {
                  int colorIndex = index;
                  print(mainScreenList.length);
                  if (colorIndex >= colorsList.length - 1) {
                    colorIndex = colorsList.length - 1;
                  }
                  Color color = colorsList[colorIndex];
                  String title = mainScreenList[index]['title'].toString();
                  var args = mainScreenList[index]['tasks'];
                  final TextEditingController controller =
                      TextEditingController(text: title);
                  final key = ValueKey(mainScreenList[index]['id']);
                  final bool isDone = mainScreenList[index]['isDone'] as bool;
                  final Map item = mainScreenList[index];
                  var lists = mainScreenList[index]['tasks'];
                  return List(
                    color: color,
                    title: title,
                    controller: controller,
                    key: key,
                    isDone: isDone,
                    lists: lists,
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class List extends StatefulWidget {
  const List(
      {required this.color,
      required this.title,
      required this.controller,
      required this.key,
      required this.isDone,
      required this.lists,
      required this.index});

  final Color color;
  final String title;
  final TextEditingController controller;
  @override
  final Key key;
  final bool isDone;
  final lists;
  final int index;

  @override
  State<List> createState() => _ListState();
}

class _ListState extends State<List> {
  bool visibility = false;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: widget.key,
      confirmDismiss: (direction) async {
        return false;
      },
      background: DeleteOrCheck.checkContainer,
      secondaryBackground: DeleteOrCheck.deleteContainer,
      child: InkWell(
        onTap: () {
          
        },
        child: Container(
            color: widget.isDone ? Colors.grey[700] : widget.color,
            width: double.infinity,
            // height: 80,
            // margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.green,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: EditableText(
                    onSubmitted: (value) {
                      setState(() {
                        widget.controller.text = value;
                        mainScreenList[widget.index]['title'] = value;
                        print(mainScreenList[widget.index]['title']);
                      });
                    },
                    backgroundCursorColor: Colors.black,
                    cursorColor: Colors.black,
                    controller: widget.controller,
                    focusNode: FocusNode(),
                    style: GoogleFonts.quicksand(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Visibility(
                  visible: visibility,
                  child: InkWell(
                    child: Text(
                      'Add reminder',
                      style: GoogleFonts.quicksand(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
