// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print
import 'package:clear_to_do/materials/add_list_componenets.dart';
import 'package:clear_to_do/model/models.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../splashScreens/splash_screens.dart';

class MainSubScreen extends StatefulWidget {
  static const String id = 'MainSubScreen';
  final list;
  MainSubScreen({required this.list});

  @override
  _MainSubScreenState createState() => _MainSubScreenState();
}

class _MainSubScreenState extends State<MainSubScreen> {
  List<dynamic> generatedList = subList;
  @override
  void initState() {
    // super.initState();
    print(generatedList);
    print(generatedList.runtimeType);
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
                  title: 'Add tasks to do',
                  buttonFunction: () {
                    setState(() {
                      print(generatedList);
                      generatedList.insert(0, userGeneratedValue);
                    });
                    
                  }),
            ),
            Expanded(
              flex: 9,
              child: ListView.builder(
                itemCount: generatedList.length,
                itemBuilder: (context, index) {
                  int val = (255 - (index * 30));
                  if (val <= 0) val = 0;
                  var _text = generatedList[index];

                  return Container(
                    color: Color.fromRGBO(0, 0, val, 1),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      onTap: () {},
                      title: Text(
                        _text,
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
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
