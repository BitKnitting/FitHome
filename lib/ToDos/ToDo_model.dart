//
// The purpose of this code is to return a list of todos.  The contents
// of this list varies depending if the caller wants ToDos that are
// active for the user or not active for the user.
//
import 'dart:convert';
import 'package:flutter/services.dart';


Future<Map> loadToDos() async {
  Map mapToDos;
  try {
    final jsonString = await rootBundle.loadString('assets/ToDos/ToDo_data.json');
    // Loading finished.  Now it's time to convert.
     mapToDos = jsonDecode(jsonString);
  } catch(e) {
    print("Couldn't get the Json String.");
    return null;
  }
  return mapToDos;
}
