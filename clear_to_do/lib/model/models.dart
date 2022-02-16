// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

List<Map<String, Object>> mainScreenList = [
  {'id': 0, 'title': 'Personal List', 'isDone': false, 'tasks': []},
  {'id': 1, 'title': 'Title 2', 'isDone': false, 'tasks': []},
];

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

String userGeneratedValue = '';
var subList;
var headingTaskList = [
  {
    'name': 'List 1',
    'task': ['Excercise', 'Task 2', 'Task 3']
  },
  {
    'name': 'List 2',
    'task': ['Task 1', 'Task 2']
  },
  {
    'name': 'List 3',
    'task': ['Task 1', 'Task 2']
  },
];
