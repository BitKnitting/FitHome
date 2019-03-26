import 'dart:convert';

import 'package:fithome/Users/user.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activities.g.dart';

//******************************************** */
@JsonSerializable()
class Activities {
  Activities({
    this.activities,
  });

  final List<Activity> activities;
  List<Activity> activeActivities;

// fromJson and toJson are part of using the json serializer
  factory Activities.fromJson(Map<String, dynamic> json) =>
      _$ActivitiesFromJson(json);

  Map<String, dynamic> toJson() => _$ActivitiesToJson(this);
  //******************************************** */
  /// Load all available activities.
  Future<List<Activity>> loadActivities() async {
    // Load the Json file that contains the activities. Note: loadString will cache the
    String jsonString = await rootBundle.loadString('assets/activities.json');
    Map activitiesMap = jsonDecode(jsonString);
    return Activities.fromJson(activitiesMap).activities;
  }

  //
  /// Get Active Activities for the User
  Future<List<Activity>> getActiveActivities() async {
    List<Activity> activitiesList = await loadActivities();

    List<Activity> activeActivities = [];
    for (var activity in activitiesList) {
      // If the current user's completedActivities list does not include the activity, add to the activeActivities
      if (User.namesOfCompletedActivities
              .where((completedName) => completedName == activity.name)
              .length ==
          0) {
        activeActivities.add(activity);
      }
    }
    return activeActivities;
  }

  /// Get Completed Activities for the User
  Future<List<Activity>> getCompletedActivities() async {
    List<Activity> activitiesList = await loadActivities();
    List<Activity> completedActivities = [];
    for (var activity in activitiesList) {
      // If the current user's completedActivities list does not include the activity, add to the activeActivities
      if (User.namesOfCompletedActivities
              .where((completedName) => completedName == activity.name)
              .length >
          0) {
        completedActivities.add(activity);
      }
    }
    return completedActivities;
  }
}

//******************************************** */
@JsonSerializable()
class Activity {
  Activity({this.name, this.icon, this.tip, this.checklist});
  final String name;
  final String icon;
  final String tip;
  final List<Checklist> checklist;
//************************************ */
  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
//************************************ */

@JsonSerializable()
class Checklist {
  Checklist(this.todo, this.url);
  final String todo;
  final String url;
  factory Checklist.fromJson(Map<String, dynamic> json) =>
      _$ChecklistFromJson(json);

  Map<String, dynamic> toJson() => _$ChecklistToJson(this);
}
