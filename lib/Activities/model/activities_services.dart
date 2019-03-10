//
// Higher level access to Activities data
//
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'activities_schema.dart';
import '../../Users/users.dart';

class ActivitiesService {
  List<Activity> activitiesList = [];
  User currentUser;
  // Load the activities into the created instance.  This will hold the available activities.
  ActivitiesService() {
    load();
  }

  void load() {
    _loadJson();
  }

// Get the list of activities this user has not completed.
  Future<List<Activity>> activeActivities(String userEmail) async {
    User currentUser = await _getUser(userEmail);
    return _getActiveActivities(currentUser);
  }

  // Get the list of activities this user has completed.
  Future<List<Activity>> completedActivities(String userEmail) async {
    User currentUser = await _getUser(userEmail);
    return _getCompletedActivities(currentUser);
  }

//
// _loadJson loads activities from a json asset file into the instance's activitiesList
//
  Future<void> _loadJson() async {
    String jsonString = await rootBundle.loadString('assets/activities.json');
    Map activitiesMap = jsonDecode(jsonString);
    Activities activities = Activities.fromJson(activitiesMap);
    activitiesList = activities.activities;
  }

//
// _getUser finds the user information (currently this is the completedActivities list) for the
// user with the passed in user email string.
//
  Future<User> _getUser(String userEmail) async {
    String jsonString = await loadUsers();
    Map usersMap = jsonDecode(jsonString);
    Users users = Users.fromJson(usersMap);
    User currentUser = users.users
        .singleWhere((user) => user.email == userEmail, orElse: () => null);
    return currentUser;
  }

  Future<List<Activity>> _getActiveActivities(User user) async {
    List<Activity> activeActivities = [];
    for (var activity in activitiesList) {
      // If the current user's completedActivities list does not include the activity, add to the activeActivities
      if (user.completedActivities
              .where((completedActivity) => completedActivity == activity.name)
              .length ==
          0) {
        activeActivities.add(activity);
      }
    }
    return activeActivities;
  }

  Future<List<Activity>> _getCompletedActivities(User user) async {
    List<Activity> completedActivities = [];
    for (var activity in activitiesList) {
      // If the current user's completedActivities list does not include the activity, add to the activeActivities
      if (true ==
          user.completedActivities
                  .where(
                      (completedActivity) => completedActivity == activity.name)
                  .length >
              0) {
        completedActivities.add(activity);
      }
    }
    return completedActivities;
  }
}
