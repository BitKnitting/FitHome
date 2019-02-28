import 'package:flutter/material.dart';
import 'bottom_navbarpage.dart';
import 'dashboard/impact_images.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Prime the image cache with the images that will
    // be displayed in the background.
    ImpactImages.impactURLs.forEach((urlString) =>
    precacheImage(NetworkImage(urlString), context));
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
