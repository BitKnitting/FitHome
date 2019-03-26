import 'package:fithome/Activities/checklist_page.dart';
import 'package:fithome/Activities/model/activities.dart';
import 'package:flutter/material.dart';
import '../icons/icon_loader.dart';
import '../Users/user.dart';

class ActivitiesPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ActivitiesPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
//                icon: Icon(Icons.directions_car),
                text: "Active",
              ),
              Tab(
                  //icon: Icon(Icons.directions_transit),
                  text: "Completed"),
            ],
          ),
          title: Text('Activities'),
        ),
        body: TabBarView(
          // One child is a ListView of Active ToDos.
          // The Other is a ListView of Completed ToDos.
          children: [
            // Getting the active and completed activities takes longer than displaying UI...so I
            // am using FutureBuilder.
            FutureBuilder(
                // Once the data is available, display it...
                future: Activities().getActiveActivities(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // The active activities are available.
                  if (snapshot.connectionState == ConnectionState.done) {
                    return _listViewActiveActivities(snapshot.data);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            FutureBuilder(
                // The activities will be put into a List of Activities, but it will happen in the
                // future because it will take longer than it will for the UI to draw.
                //
                future: Activities().getCompletedActivities(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // The completed activities are available.
                  if (snapshot.connectionState == ConnectionState.done) {
                    return _listViewCompletedActivities(snapshot.data);
                  } else {
                    // Until the activities can be loaded show a circular progress indicator.
                    return CircularProgressIndicator();
                  }
                }),
          ],
        ),
      ),
    );
  }

//
// Passing in bool active is for the button that says either 'mark completed' (if active)
// or 'mark active' (if the activity is currently marked as completed).  This way, the user
// can change the active/completed state of an activity.
//
  Widget _listViewCompletedActivities(List<Activity> activities) {
    return _makeBody(false, activities);
  }

  Widget _listViewActiveActivities(List<Activity> activities) {
    return _makeBody(true, activities);
  }

  Widget _makeBody(bool active, List<Activity> activities) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: activities.length,
        itemBuilder: (BuildContext context, int index) {
          return _makeCard(active, activities[index]);
        },
      ),
    );
  }

  Widget _makeCard(bool active, Activity activity) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: _makeListTile(active, activity),
      ),
    );
  }

  Widget _makeListTile(bool active, Activity activity) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(
          width: 1.0,
        ))),
        child:
            // First displays the icon assigned to the activity
            Icon(getIcon(name: activity.icon)),
        // Next, an icon button is there to show hint text.
        // ToDO: Green text button "show hint"?
      ),
      title: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              activity.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          FlatButton(
            // If active is true, the user can set to completed by tapping on button.
            // Of course if completed, can tap on button to make the activity active again.
            child: Text(active == true ? "Mark Completed" : "Mark Active"),
            textColor: Colors.green,
            splashColor: Colors.green,
            shape: StadiumBorder(),
            onPressed: () {
              setState(() {
                // If the current state is active, this means the user tapped on
                // Marking the activity as complete.
                if (active == true) {
                  // Add the activity name to the list of completed activities.
                  User.addCompletedActivity(activity.name);
                  // Mark all the ToDos as completed
                  User.updateChecklistCompletes(
                      activity.name, [true, true, true]);
                } else {
                  User.removeCompletedActivity(activity.name);
                  // The once completed activity is now being made active, so setting
                  // the ToDo checkboxes to "not done" (false).
                  User.updateChecklistCompletes(
                      activity.name, [false, false, false]);
                }
              });
            },
          ),
          // This seems a bit confusing ...but if active is true, it means the active page is showing.
          // the user tapped on "Mark Completed".  So we add this activity to the names of completed activities.
        ],
      ),
      subtitle: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: FlatButton(
                child: Text('more info...',
                    style: TextStyle(decoration: TextDecoration.underline)),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        elevation: 10.0,
                        title: Text(activity.name),
                        content: Text(activity.tip),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Got It"),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    },
                  );
                  // TODO: pressed more info....
                },
              ),
            ),
          ),
          //   child: Text(activity.tip,
          //       style: TextStyle(
          //           color: Colors.black, fontWeight: FontWeight.bold)),
          // )),
        ],
      ),
      trailing: Icon(Icons.keyboard_arrow_right, size: 30.0),
      onTap: () {
        _showChecklist(activity);
      },
    );
  }

  void _showChecklist(Activity activity) {
    // Go to the check list page.
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChecklistPage(activity: activity)));
    // Display the checklist for this activity.
  }
}
