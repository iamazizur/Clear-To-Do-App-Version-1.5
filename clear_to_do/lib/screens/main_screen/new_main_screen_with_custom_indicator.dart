// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, prefer_typing_uninitialized_variables, unused_element, must_be_immutable, unused_field, avoid_unnecessary_containers, unused_local_variable, sized_box_for_whitespace
import 'package:clear_to_do/materials/add_list_componenets.dart';
import 'package:clear_to_do/materials/delete_check_widget.dart';
import 'package:clear_to_do/model/models.dart';
import 'package:clear_to_do/screens/main_screen/main_sub_screen.dart';
import 'package:clear_to_do/screens/main_screen/new_task_list.dart';
import 'package:clear_to_do/screens/main_screen/task_list_firestore.dart';
import 'package:clear_to_do/utils/firestore_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../splashScreens/splash_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreenCustomIndicator extends StatefulWidget {
  static const String id = 'MainScreenCustomIndicatorFirebase';

  @override
  _MainScreenCustomIndicatorState createState() =>
      _MainScreenCustomIndicatorState();
}

class _MainScreenCustomIndicatorState extends State<MainScreenCustomIndicator> {
  FirestoreFunctions firestoreFunctions = FirestoreFunctions(
      collectionReference: FirebaseFirestore.instance.collection('collection'));
  CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance.collection('collection');
  bool isVisible = true;
  IndicatorController controller = IndicatorController(refreshEnabled: true);
  void fun(IndicatorController controller) {
    controller.setIndicatorState(IndicatorState.hiding);
  }

  @override
  Widget build(BuildContext context) {
    var color = Colors.black;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: CustomRefreshIndicator(
          completeStateDuration: const Duration(seconds: 10),
          loadingToIdleDuration: const Duration(seconds: 10),
          armedToLoadingDuration: const Duration(seconds: 10),
          draggingToIdleDuration: const Duration(seconds: 10),
          leadingGlowVisible: true,
          trailingGlowVisible: true,
          offsetToArmed: 80,
          controller: controller,
          // onRefresh: () async => Future.delayed(Duration(microseconds: 5)),

          onRefresh: () async {
            // return Future.delayed(Duration(seconds: 5), () {
            //   print('object');
            // });
          },
          child: ListStreams(
            collectionReference: collectionReference,
            parentId: '',
            firestoreFunctions: firestoreFunctions,
            mainScreen: true,
            ontap: () {},
          ),
          builder: (BuildContext context, Widget child,
              IndicatorController controller) {
            return Stack(
              children: [
                AddListWidget(
                  buttonFunction: () async {
                    FirestoreFunctions(
                        collectionReference:
                            FirebaseFirestore.instance.collection('collection'),
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
                AnimatedBuilder(
                    animation: controller,
                    builder: (context, snapshot) {
                      return Transform.translate(
                        // angle: 10 * _controller!.value,
                        offset: Offset(0.0, 55 * controller.value),
                        child: child,
                      );
                    }),
              ],
            );
          },
        ),
      ),
    );
  }

// to use now
/*
child: ListStreams(
            collectionReference: collectionReference,
            parentId: '',
            firestoreFunctions: firestoreFunctions,
            mainScreen: true,
            ontap: () {},
          ),
*/
  /*
  AddListWidget(
                  buttonFunction: () async {
                    FirestoreFunctions(
                        collectionReference:
                            FirebaseFirestore.instance.collection('collection'),
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
  */
  /*
      Unused
          Future<void> addTitle(String userGeneratedValue) async {
            CollectionReference fireStore =
                FirebaseFirestore.instance.collection('collection');

            var generatedId = await fireStore
                .add({'title': userGeneratedValue, 'id': '', 'isDone': false});

            fireStore
                .doc(generatedId.id)
                .update({'id': generatedId.id}).then((value) => print('added '));
          }
  */
}

//stream list
// class ListStreams extends StatefulWidget {
//   @override
//   State<ListStreams> createState() => _ListStreamsState();
// }

// class _ListStreamsState extends State<ListStreams> {
//   Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
//       FirebaseFirestore.instance.collection('collection').snapshots();
//   CollectionReference<Map<String, dynamic>> collectionReference =
//       FirebaseFirestore.instance.collection('collection');

//   FirestoreFunctions firestoreFunctions = FirestoreFunctions(
//     collectionReference: FirebaseFirestore.instance.collection('collection'),
//   );
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: snapshot,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           var items = snapshot.data!.docs;
//           List<dynamic> finalLists = firestoreFunctions.generateList(items);

//           return ReorderableListView.builder(
//             onReorder: ((oldIndex, newIndex) => setState(() {
//                   print('set state changed');
//                 })),
//             itemCount: finalLists.length,
//             itemBuilder: (context, index) {
//               final item = finalLists[index];
//               int len = finalLists.length;
//               int fraction = 255 ~/ (len);
//               int val = (255 - (fraction * index));
//               Color color = Color.fromRGBO((val), 0, 0, 1);
//               String title = item['title'];
//               print('item id: ${item.id.runtimeType}');
//               return listTile(
//                   item, color, index, context, title, item['isDone']);
//             },
//           );
//         }
//         return CircularProgressIndicator();
//       },
//     );
//   }

//   Widget listTile(item, Color color, int index, BuildContext context,
//       String title, bool isDone) {
//     return Dismissible(
//       key: ValueKey(item.id),
//       confirmDismiss: ((direction) async {
//         return firestoreFunctions.dismissable(direction, item);

//         /*
//         if (direction == DismissDirection.startToEnd) {
//           // changeTaskStatus(item);
//           FirestoreFunctions(collectionReference: collectionReference, map: {})
//               .changeTaskStatus(item);
//           return false;
//         } else {
//           // deleteTask(item['id']);
//           FirestoreFunctions(collectionReference: collectionReference, map: {})
//               .deleteItem(item['id']);
//           return true;

          
//         }
//         */
//       }),
//       background: DeleteOrCheck.checkContainer,
//       secondaryBackground: DeleteOrCheck.deleteContainer,
//       child: Container(
//         color: isDone ? Colors.grey[700] : color,
//         // key: Key(index.toString()),
//         child: ListTile(
//           dense: true,
//           selected: true,
//           contentPadding: EdgeInsets.all(10),
//           onTap: () {
//             // Navigator.pushNamed(context, TaskList.id);
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => NewTaskList(
//                   parentId: (item.id),
//                 ),
//               ),

//               // MaterialPageRoute(
//               //   builder: (context) => TaskList(
//               //     parentId: (item.id),
//               //   ),
//               // ),
//             );
//           },
//           title: Text(
//             title,
//             style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 25,
//                 decoration:
//                     isDone ? TextDecoration.lineThrough : TextDecoration.none),
//           ),
//         ),
//       ),
//     );
//   }

//   //functions

//   /*  
//   Unused--
//           Future<void> deleteTask(doc) async {
//             return _firebaseFirestore
//                 .collection('collection')
//                 .doc(doc)
//                 .delete()
//                 .then((value) => print('deleted'))
//                 .onError((error, stackTrace) => print(error));
//           }

//   */

//   // void changeTaskStatus(item) async {
//   //   bool status = true;
//   //   if (item['isDone']) {
//   //     status = false;
//   //   }
//   //   CollectionReference fireStore =
//   //       FirebaseFirestore.instance.collection('collection');

//   //   return await fireStore
//   //       .doc(item.id)
//   //       .update({'isDone': status}).then((value) => print('updated'));
//   // }
// }
