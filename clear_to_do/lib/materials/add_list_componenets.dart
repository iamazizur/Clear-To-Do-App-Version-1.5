// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print

import 'package:clear_to_do/model/models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddListWidget extends StatefulWidget {
  final String title;
  final Function buttonFunction;

  AddListWidget({required this.title, required this.buttonFunction});

  @override
  State<AddListWidget> createState() => _AddListWidgetState();
}

class _AddListWidgetState extends State<AddListWidget> {
  String userValue = '';
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            flex: 8,
            child: Container(
              alignment: Alignment.center,
              color: Colors.black,
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  userValue = value;
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.none),
                    ),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: widget.title,
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            )),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () async {
              userGeneratedValue = userValue;
              await widget.buttonFunction();
              searchController.clear();
            },
            child: Container(
              color: Colors.blue,
              child: Icon(
                FontAwesomeIcons.plus,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
