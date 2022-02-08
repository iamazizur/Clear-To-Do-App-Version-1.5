// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, prefer_typing_uninitialized_variables, unused_element, must_be_immutable, unused_field, avoid_unnecessary_containers, unused_local_variable, sized_box_for_whitespace
import 'package:clear_to_do/materials/add_list_componenets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';

class FirestoreFunctions {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference collectionReference;
  // final String value;

  // final String collectionId;
  final Map<String, dynamic> map;

  FirestoreFunctions({required this.collectionReference, required this.map});

  Future<void> addItem() async {
    var generatedId = await collectionReference.add(map);

    collectionReference
        .doc(generatedId.id)
        .update({'id': generatedId.id}).then((value) => print('SUCCESS!'));
  }
}
