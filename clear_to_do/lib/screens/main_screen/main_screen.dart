// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, unused_local_variable
import 'package:clear_to_do/materials/add_list_componenets.dart';
import 'package:clear_to_do/model/models.dart';
import 'package:clear_to_do/screens/main_screen/main_sub_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../splashScreens/splash_screens.dart';
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

  CollectionReference tasks = FirebaseFirestore.instance.collection('lists');
  void fun() async {
    var taskList = await tasks.get().then((value) {
      print(value.docs[0]);
      print(value.docs.runtimeType);
    });
    // var x = taskList;
    // print(x);
    // print(x.runtimeType);
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    // print(tasks.doc());
    fun();
  }

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
                    Map<String, Object> map = {
                      'name': userGeneratedValue,
                      'task': []
                    };
                    headingTaskList.insert(0, map);
                  });
                },
              ),
            ),
            Expanded(
              flex: 8,
              child: ListView.builder(
                itemCount: headingTaskList.length,
                itemBuilder: (context, index) {
                  int val = (255 - (index * 30));
                  if (val <= 0) val = 0;
                  var _text = headingTaskList[index]['name'].toString();
                  var _args = headingTaskList[index]['task'];

                  return Container(
                    color: Color.fromRGBO((val), 0, 0, 1),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      onTap: () {
                        // Navigator.pushNamed(context, MainSubScreen.id);
                        Navigator.of(context)
                            .pushNamed('/mainSubScreen', arguments: _args);
                      },
                      onLongPress: () {
                        setState(() {
                          headingTaskList.removeAt(index);
                          print('Long Pressed at index: $index');
                        });
                      },
                      title: Text(
                        _text,
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
                flex: 1,
                child: ElevatedButton(
                  child: Text('getMapData'),
                  onPressed: () {
                    headingTaskList.forEach((element) {
                      if (element['name'] == 'List 1') print('found');
                    });
                  },
                )),
          ],
        ),
      ),
    );
  }
}
