import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';
import 'root_page.dart';
import 'State_Management/state_container.dart';
import 'Members/member.dart';

void main() {
  _initLogger();
  runApp(MyApp());
}
// *************************************************************************************
// FitHome's start of it's widget tree.  It starts with an inherited widget to hold Member
// state, then the MaterialApp widget. The Material App widget instantiates the RootPage
// widget.  The RootPage widget determines which way to go - a page to get the email and password,
// or - if we already have the email and password - routes us to the Dashboard.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String title = 'FitHome';
    return StateContainer(  // Wrap in an inherited widget to manage the member's state.
      member: Member(),
      child: MaterialApp(
        title: title,
        home: RootPage(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}

// *************************************************************************************
// Code to set up logger.
void _initLogger() {
  Logger.root.level = Level.ALL; // i.e.: INFO.
  Logger.root.onRecord.listen((LogRecord rec) {
    final List<Frame> frames = Trace.current().frames;
    try {
      final Frame f = frames.skip(0).firstWhere((Frame f) =>
          f.library.toLowerCase().contains(rec.loggerName.toLowerCase()) &&
          f != frames.first);
      print(
          '${rec.level.name}: ${f.member} (${rec.loggerName}:${f.line}): ${rec.message}');
    } catch (e) {
      print(e.toString());
    }
  });
}


