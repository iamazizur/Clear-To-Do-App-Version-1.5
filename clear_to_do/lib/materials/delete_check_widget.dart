// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, prefer_typing_uninitialized_variables, unused_element, must_be_immutable, unused_field, avoid_unnecessary_containers, unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';

class DeleteOrCheck {
  
  static Container deleteContainer = Container(
    color: Colors.black,
    alignment: Alignment.centerRight,
    padding: EdgeInsets.only(right: 10),
    child: Icon(
      Icons.delete,
      color: Colors.white,
    ),
  );

  static Container checkContainer = Container(
    color: Colors.green,
    child: Icon(
      Icons.check,
      color: Colors.white,
    ),
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(left: 10),
  );
}
