import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

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
          body: Guides(),
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
            GuideEntry(imgUrl: 'img1.jpg', name: 'Name1'),
            GuideEntry(imgUrl: "img2.jpg", name: "Name2")
          ],
        );
      }

      /// TEMP CODE SO DART DOESN'T CRY
      return PageView(
        children: [
          GuideEntry(imgUrl: 'img1.jpg', name: 'Name1'),
          GuideEntry(imgUrl: "img2.jpg", name: "Name2")
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
  const GuideEntry({Key? key, required this.imgUrl, required this.name})
      : super(key: key);

  final String imgUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}

// Builders


