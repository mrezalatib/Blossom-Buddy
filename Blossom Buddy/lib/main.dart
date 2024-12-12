import 'package:flutter/material.dart';
import 'package:frontend/features/app/splash_screen/splash_screen.dart';
import 'package:frontend/features/user_auth/presentation/pages/login_page.dart';
import 'package:frontend/tasks.dart';
import 'package:frontend/timer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(
        child: LoginPage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    myBlossomTasks(),
    blossomTimer(),
    const Text('Garden Page'),
    const Text('Profile Page'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blossom Buddy'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xFFFCC9C5),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Color(0xFFFFFFFF),
          unselectedItemColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.checklist),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timelapse_rounded),
              label: 'Timer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_florist),
              label: 'Garden',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
