// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, prefer_typing_uninitialized_variables, unused_element, must_be_immutable, unused_field, avoid_unnecessary_containers, unused_local_variable, sized_box_for_whitespace

import 'package:clear_to_do/screens/main_screen/new_main_screen.dart';
import 'package:clear_to_do/screens/splashScreens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

List<Color> blackColors = [
  Colors.grey.withOpacity(0.2),
  Colors.grey.withOpacity(0.3),
  Colors.grey.withOpacity(0.4),
  Colors.grey.withOpacity(0.5),
  Colors.grey.withOpacity(0.6),
  Colors.grey.withOpacity(0.7),
  Colors.grey.withOpacity(0.8),
];

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  static const String id = 'Settings';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: [
            MyList(
              size: size,
              title: 'My List',
              ontap: () {
                Navigator.pushNamed(context, NewMainScreenFirebase.id);
              },
              index: 0,
            ),
            MyList(
              size: size,
              title: 'Themes',
              ontap: () {},
              index: 1,
            ),
            MyList(
              size: size,
              title: 'Guide',
              ontap: () {
                Navigator.pushNamed(context, SplashScreen.id);
              },
              index: 2,
            ),
            MyList(
              size: size,
              title: 'Tips and Tricks',
              ontap: () {},
              index: 3,
            ),
            MyList(
              size: size,
              title: 'Privacy and policy',
              ontap: () {},
              index: 4,
            ),
            MyList(
              size: size,
              title: 'Feedback',
              ontap: () {},
              index: 5,
            ),
            MyList(
              index: 6,
              size: size,
              title: 'Rate',
              ontap: () {
                showDialog(
                    context: context,
                    builder: (context) => Dialog(
                          child: RatingDialog(),
                        ));
              },
            ),
            // RatingDialog(),
          ],
        ));
  }
}

class MyList extends StatelessWidget {
  const MyList(
      {Key? key,
      required this.size,
      required this.title,
      required this.ontap,
      required this.index})
      : super(key: key);

  final double size;
  final String title;
  final Function ontap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: Container(
        padding: EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        height: size * 0.2,
        color: blackColors[index],
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class RatingDialog extends StatefulWidget {
  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  List<bool> ratings = List.generate(5, (index) => false);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;

    List<Widget> stars = List.generate(5, (index) {
      // bool isRated = false;
      return InkWell(
        onTap: () {
          setState(() {
            for (var i = 0; i <= index; i++) {
              ratings[i] = true;
            }
            for (var i = index + 1; i < 5; i++) {
              ratings[i] = false;
            }
          });
        },
        child: Icon(
          Icons.star,
          size: 40,
          color: (ratings[index]) ? Colors.pink : Colors.grey,
        ),
      );
    });
    return Container(
      width: size * 0.9,
      height: size * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: HexColor('#E9E3DE'),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 100,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Tasks Todo',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'How much do you love our app?',
            style: TextStyle(
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: stars,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Container(
                  width: size * 0.4,
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: InkWell(
                      onTap: (() {
                        Navigator.pop(context);
                      }),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  width: size * 0.4,
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      'Rate',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class Ratings extends StatefulWidget {
//   const Ratings({Key? key}) : super(key: key);

//   @override
//   _RatingsState createState() => _RatingsState();
// }

// class _RatingsState extends State<Ratings> {
//   List<bool> ratings = List.generate(5, (index) => false);

//   List<Widget> stars = List.generate(5, (index) {
//     bool isRated = false;
//     return InkWell(
//       onTap: () {
//         print(index);
//       },
//       child: Icon(
//         Icons.star,
//         size: 40,
//         color: (ratings[index]) ? Colors.pink : Colors.grey,
//       ),
//     );
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
