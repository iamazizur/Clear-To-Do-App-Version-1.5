// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, prefer_typing_uninitialized_variables, unused_element, must_be_immutable, unused_field, avoid_unnecessary_containers, unused_local_variable, sized_box_for_whitespace
import 'package:clear_to_do/materials/add_list_componenets.dart';
import 'package:clear_to_do/model/models.dart';
import 'package:clear_to_do/screens/main_screen/main_sub_screen.dart';
import 'package:clear_to_do/screens/main_screen/task_list_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);
  static const String id = 'check';

  @override
  _CheckState createState() => _CheckState();
}

double dy = 10;

class _CheckState extends State<Check> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          
          onVerticalDragEnd: (details) {
            print('end');
            setState(() {
              dy = 0;
            });
          },
          onVerticalDragDown: (details) {
            print(details.runtimeType);
            setState(() {});
          },
          onVerticalDragUpdate: (details) {
            if(details.localPosition.dy > 200){

            }
            setState(() {
              var x = details.localPosition;

              dy = x.dy;
              print('dy: $dy');
            });
          },
          child: Stack(children: [
            Container(
              width: 300,
              height: 200,
              color: Colors.red,
            ),
            Transform.translate(
              offset: Offset(0, 0.1*dy),
              child: Container(
                margin: EdgeInsets.only(top: 30),
                width: 300,
                height: 200,
                color: Colors.cyan,
              ),
            ),
           
          ]),
        ),
      ),
    );
  }
}
























// class Check extends StatefulWidget {
//   const Check({Key? key}) : super(key: key);
//   static const String id = 'check';

//   @override
//   _CheckState createState() => _CheckState();
// }

// class _CheckState extends State<Check> {
//   bool isVisible = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: RefreshIndicator(
//         onRefresh: (() async {
//           setState(() {
//           isVisible = (isVisible) ? false : true ;
//           });
//         }),
//         child: Column(
//           children: [
//             Visibility(
//               visible: isVisible,
//               child: Expanded(
//                 flex: 2,
//                   child: Container(
//                 color: Colors.green,
//               )),
//             ),
//             Expanded(
//               flex: 8,
//               child: ReorderableListView.builder(
//                 onReorder: (oldIndex, newIndex) {
//                   print('oldIndex : $oldIndex');
//                   print('newIndex : $newIndex');
//                 },
//                 itemCount: 6,
//                 itemBuilder: (context, index) {
//                   return Visibility(
//                     key: ValueKey(index * 20),
//                     visible: (index == 3) ? true : true,
//                     child: (index == 3)
//                         ? Container(
//                             margin: EdgeInsets.all(10),
//                             height: 50,
//                             color: Colors.red,
//                           )
//                         : Container(
//                             margin: EdgeInsets.all(10),
//                             height: 50,
//                             color: Colors.amber,
//                           ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
