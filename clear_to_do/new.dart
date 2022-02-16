// // ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, unused_local_variable, prefer_final_fields, unused_field

// import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
// import 'package:flutter/material.dart';

// class DragListScreen extends StatefulWidget {
//   const DragListScreen({Key? key}) : super(key: key);
//   static const String id = 'dragscreen';

//   @override
//   _DragListScreenState createState() => _DragListScreenState();
// }

// class _DragListScreenState extends State<DragListScreen> {
//   List<DragAndDropList> _contents = List.generate(5, (index) {
//     return DragAndDropList(
//       children: [
//         DragAndDropItem(
//           child: Container(
//             color: Colors.amber,
//             width: 400,
//             // height: 200,
//             alignment: Alignment.center,
//             padding: EdgeInsets.all(20),
//             child: Container(
//               color: Colors.green,
//               width: 100,
//               height: 50,
//               child: TextFormField(
//                 // expands: false,
//                 // backgroundCursorColor: Colors.black,
//                 controller: TextEditingController(text: '${index * 100}'),
//                 cursorColor: Colors.black,
//                 focusNode: FocusNode(),
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DragAndDropLists(
        
//         children: _contents,
//         onItemReorder: onItemReorder,
//         onListReorder: onListReorder,
//       ),
//     );
//   }

//   onItemReorder(
//       int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {}
//   onListReorder(int oldItemIndex, int oldListIndex) {}
// }
