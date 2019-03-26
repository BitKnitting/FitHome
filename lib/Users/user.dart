import 'package:shared_preferences/shared_preferences.dart';

class User {
  ///Lookup string for email.
  static String emailString = "email";

  ///Lookup string for the list of the names of completed activities.
  static String completedActivitiesString = "namesOfCompltedActivities";

  ///The User's email address.
  static String email;

  ///The names of the activities the User has completed.
  static List<String> namesOfCompletedActivities;

  /// Add activity name to the list of  completed activities.
  static Future<void> addCompletedActivity(String activityName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //if the completed Activity is not in the completed activity list
    if (namesOfCompletedActivities
            .where((completedName) => completedName == activityName)
            .length ==
        0) {
      namesOfCompletedActivities.add(activityName);
      prefs.setStringList(
          completedActivitiesString, namesOfCompletedActivities);
    }
  }

  /// Remove activity name from the list of  completed activities.
  static Future<void> removeCompletedActivity(String activityName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //if the completed Activity is not in the completed activity list
    namesOfCompletedActivities
        .removeWhere((completedName) => completedName == activityName);
    prefs.setStringList(completedActivitiesString, namesOfCompletedActivities);
  }

  /// Updates which todo items for an activity have been completed.
  /// The String activityName is the name of the activity.
  /// The List<bool> completes contains whether the todo is completed or not.
  /// For example, if a checklist has three todos and the first is completed,
  /// completes would be [true,false,false].
  static Future<void> updateChecklistCompletes(
      String activityName, List<bool> completes) async {
    // Set up List<String> to save....
    List<String> listOfCompletes = [];
    for (var todo in completes) {
      todo ? listOfCompletes.add('true') : listOfCompletes.add('false');
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(activityName, listOfCompletes);
  }

  /// The UI shows which todo items within a checklist have been completed.
  /// This info has been stored.
  static Future<List<bool>> getChecklistCompletes(
      String activityName, int numToDos) async {
    print("in getChecklistCompletes");
    List<bool> completes = [];
    List<String> completedToDosStringList = [];
    String trueString = 'true';
    // There might not be any completedToDos registered yet.  In this case, an exception will be raised.
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      completedToDosStringList = prefs.getStringList(activityName);
      // The ToDo string contains string entries of 'true' or 'false'.  This is because
      // shared prefs deals only with List<String> ... so put the boolean equivalent into the completes list.
      for (var todoString in completedToDosStringList) {
        todoString == trueString ? completes.add(true) : completes.add(false);
      }
    } catch (e) {
      // No info on the completed ToDos is available yet.
      print(e);
      for (var i = 0; i < numToDos; i++) {
        completes.add(false);
      }
    }

    print('at bottom of getChecklistCompletes');
    return completes;
  }
}
