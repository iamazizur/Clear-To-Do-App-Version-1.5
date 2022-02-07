// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, prefer_typing_uninitialized_variables, unused_element, must_be_immutable, unused_field, avoid_unnecessary_containers, unused_local_variable, sized_box_for_whitespace
import 'package:clear_to_do/materials/add_list_componenets.dart';
import 'package:clear_to_do/model/models.dart';
import 'package:clear_to_do/screens/main_screen/main_sub_screen.dart';
import 'package:clear_to_do/screens/main_screen/task_list_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dissmisable extends StatefulWidget {
  static const String id = 'Dissmisable';

  @override
  _DissmisableState createState() => _DissmisableState();
}

FirebaseFirestore _tasks = FirebaseFirestore.instance;

class _DissmisableState extends State<Dissmisable> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('collection').snapshots(),
          builder: (context, snapshot) {
            List<dynamic> items = [];
            if (snapshot.hasData) {
              var x = snapshot.data!.docs;
              print(x.length);
              for (var item in x) {
                // print(item['title']);
                items.add(item);
              }
              for (var item in items) {
                print(item['title']);
                print(item['id']);
              }

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Dismissible(
                    
                    onDismissed: (direction) {
                      print(direction);
                      if (direction == DismissDirection.endToStart) {
                        deleteTask(item['id']);
                      } else {
                        setState(() {});
                      }
                    },
                    key: Key(item['id']),
                    background: Container(
                      color: Colors.blue,
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: Container(
                      color: Colors.amber,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Text(
                          item['title'].toString(),
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future<void> deleteTask(item) async {
    FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    return await _firebaseFirestore
        .collection('collection')
        .doc(item)
        .delete()
        .then((value) => print('deleted'))
        .onError((error, stackTrace) => print(error));
  }
}

//stream list
