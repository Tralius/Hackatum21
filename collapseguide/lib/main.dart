import 'package:collapseguide/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

final colors = AppColors();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'HackaTum21',
        theme: ThemeData(fontFamily: 'Mogra'),
        home: Scaffold(
          body: TaskPage(),
        ));
  }
}

class Guides extends StatefulWidget {
  const Guides({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

// ToDo implement firebase
class _State extends State<Guides> {
  final PageController ctrl = PageController();

  // Initialize flutterfire
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          //return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return PageView(
            children: [
              GuideEntry(
                imgUrl: 'img1.jpg',
                name: 'Name1',
                text: 'Lorem Ipsum',
              ),
              GuideEntry(
                imgUrl: "img2.jpg",
                name: "Name2",
                text: 'Lorem Ipsum',
              )
            ],
          );
        }

        /// TEMP CODE SO DART DOESN'T CRY
        return PageView(
          children: [
            GuideEntry(
              imgUrl: 'img1.jpg',
              name: 'Name1',
              text: 'Lorem Ipsum',
            ),
            GuideEntry(
              imgUrl: "img2.jpg",
              name: "Name2",
              text: 'Lorem Ipsum',
            )
          ],
        );

        ///TEMP CODE

        // Otherwise, show something whilst waiting for initialization to complete
        //return Loading();
      },
    );
  }
}

// Entry in guide (1 for every guide database entry)
// Data: Name and img link
class GuideEntry extends StatelessWidget {
  const GuideEntry(
      {Key? key, required this.imgUrl, required this.name, required this.text})
      : super(key: key);

  final String imgUrl;
  final String name;
  final String text;

  @override
  Widget build(BuildContext context) {
    return PageView(
        pageSnapping: false,
        scrollDirection: Axis.vertical,
        children: [
          Container(
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.50,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(this.imgUrl), fit: BoxFit.cover)),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(this.name),
                    Column(
                      children: [
                        Center(child: Text('Explore')),
                        Icon(Icons.arrow_downward)
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            child: Text(this.text),
          )
        ]);
  }
}

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return PageView(children: [
      TaskEntry(
        name: 'name1',
        text: 'Lorem Ipsum',
      ),
      TaskEntry(name: 'name2', text: 'Lorem Ipsum'),
    ]);
  }
}

class TaskEntry extends StatelessWidget {
  TaskEntry({Key? key, required this.name, required this.text})
      : super(key: key);

  final String name;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: colors.nature3,
        child: Column(
          children: [
            Container(),
            Stack(
              children: [
                Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        color: colors.nature4,
                        constraints:
                            BoxConstraints(maxHeight: 300.0, maxWidth: 300.0),
                        alignment: AlignmentDirectional(0.0, 0.0),
                      )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(this.name), Text(this.text)],
                )
              ],
            ),
            Container()
          ],
        ));
  }
}

// Builders


