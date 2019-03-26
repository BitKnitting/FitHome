import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Users/user.dart';

/// Check if there is email and completedActivities in a local json file for the user.
Future<bool> checkIfAuthenticated() async {
  // Get the user's email and completedActivities from shared preferences.
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // Testing, so use a default...
    // Create the user object.
  // Right now just testing.
  // TODO: Check if not null and in right format.  If not return false.
  User.email = prefs.getString(User.emailString) ?? 'happyday.mjohnson@gmail.com';
  User.namesOfCompletedActivities = prefs.getStringList(User.completedActivitiesString) ?? [];
  print('-->checkIfAuthenticated');
  await Future.delayed(
    Duration(seconds: 2),
  ); // could be a long running task, like a fetch from keychain
  print('returning the user is authenticated');
  return true;
}

/// Displayed when we don't know info on the user.
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Login page"),
    );
  }
}
