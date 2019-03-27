import 'package:flutter/material.dart';
import 'bottom_navbarpage.dart';
import 'login/login.dart';
//
// When launching, the FitHome app first checks if the user has their "authentication" info
// which right now is their email, completedActivities (and eventually their machine ids),
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String title = 'FitHome';
    return MaterialApp(
      title: title,
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => BottomNavBarPage(title: title),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    print('-> LandingPageState initState()');
    super.initState();
    checkIfAuthenticated().then(
      (success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logging in...'),
      ),
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
