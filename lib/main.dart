import 'package:flutter/material.dart';
import 'bottom_navbarpage.dart';
import 'dashboard/impact_images.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    String title = 'FitHome';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavBarPage(title: title),
    );
  }
}
