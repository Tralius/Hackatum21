import 'package:collapseguide/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/rendering.dart';

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
      home: const HomePage(),
      initialRoute: '/',
      routes: {
        '/taskPage': (context) => const TaskPage(),
        '/guidesPage': (context) => const Guides()
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.nature2,
        title: const Text('Millenials Guide to Climate Disaster'),
      ),
      body: const LandingPage(),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: const Text('Sections'),
            ),
            ListTile(
              title: const Text('TaskPage'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/taskPage');
              },
            ),
            ListTile(
              title: const Text('Guides'),
              onTap: () {
                Navigator.pushNamed(context, '/guidesPage');
              },
            )
          ],
        ),
      ),
    );
  }
}

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      //pageSnapping: false,
      scrollDirection: Axis.horizontal,
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('landing1.png'), fit: BoxFit.fill)),
        ),
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('landing2.png'), fit: BoxFit.fill)),
        ),
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('landing3.png'), fit: BoxFit.fill)),
        ),
        Stack(children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              backgroundColor: colors.nature2,
              child: const Icon(Icons.arrow_forward),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('landing4.png'), fit: BoxFit.fill)),
          )
        ])
      ],
    );
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

  final database = FirebaseDatabase.instance.reference();

  // Initialize flutterfire
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    final guideEntriesRef = database.child('/guideEntries/');

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
          return Scaffold(
              appBar: AppBar(
                  backgroundColor: colors.nature2,
                  title: const Text('Millenials Guide to Climate Disaster')),
              body: PageView(
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
              ),
              drawer: Drawer(
                child: ListView(
                  children: [
                    const DrawerHeader(
                      child: const Text('Sections'),
                    ),
                    ListTile(
                      title: const Text('TaskPage'),
                      onTap: () {
                        Navigator.pushNamed(context, '/taskPage');
                      },
                    ),
                    ListTile(
                      title: const Text('Guides'),
                      onTap: () {},
                    )
                  ],
                ),
              ));
        }

        /// TEMP CODE SO DART DOESN'T CRY
        return Scaffold(
            appBar: AppBar(
                backgroundColor: colors.nature2,
                title: const Text('Millenials Guide to Climate Disaster')),
            body: PageView(
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
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  const DrawerHeader(
                    child: const Text('Sections'),
                  ),
                  ListTile(
                    title: const Text('TaskPage'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/taskPage');
                    },
                  ),
                  ListTile(
                    title: const Text('Guides'),
                    onTap: () {
                      Navigator.pushNamed(context, '/guidesPage');
                    },
                  )
                ],
              ),
            ));

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
                Stack(
                  children: [
                    /*Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                            padding: EdgeInsets.only(right: 16, top: 16),
                            child: FloatingActionButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              backgroundColor: colors.nature2,
                              child: Icon(Icons.home),
                            ))),*/
                    Opacity(
                      opacity: 0.50,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(this.imgUrl),
                                fit: BoxFit.cover)),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Text(this.name),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Center(child: Text('Explore')),
                          Icon(Icons.arrow_downward)
                        ],
                      ),
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
    return Scaffold(
        body: PageView(children: [
      TaskEntry(
        name: 'name1',
        text: 'Lorem Ipsum',
        points: '10',
      ),
      TaskEntry(
        name: 'name2',
        text: 'Lorem Ipsum',
        points: '10',
      ),
    ]));
  }
}

class TaskEntry extends StatelessWidget {
  TaskEntry(
      {Key? key, required this.name, required this.text, required this.points})
      : super(key: key);

  final String name;
  final String text;
  final String points;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.nature3,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            color: colors.nature2,
            width: 100,
            height: 20,
          ),
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              constraints: BoxConstraints(minHeight: 600, maxWidth: 300),
              color: colors.nature4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          this.name,
                          textAlign: TextAlign.left,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 16, bottom: 16),
                        child: Text(this.text)),
                  )
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            backgroundColor: colors.nature2,
            child: Icon(Icons.done),
          ),
        )
      ]),
    );
  }
}

// Builders
