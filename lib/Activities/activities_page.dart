import 'package:flutter/material.dart';
import 'model/activities_schema.dart';
import 'model/activities_Services.dart';
import '../icons/icon_loader.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ActivitiesPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ActivitiesPage> {
  ActivitiesService activities;
  List<Activity> activeActivities = [];
  List<Activity> completedActivities = [];

  @override
  initState() {
    print('in initState');
    super.initState();
    activities = ActivitiesService();
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
            // Getting the active and completed activities most likely takes longer than displaying UI.
            FutureBuilder(
                // Once the data is available, display it...
                future:
                    activities.activeActivities('happyday.mjohnson@gmail.com'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // The active activities are available.
                  if (snapshot.connectionState == ConnectionState.done) {
                    return _listViewActivities(true, snapshot.data);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            FutureBuilder(
                // The activities will be put into a List of Activities, but it will happen in the
                // future because it will take longer than it will for the UI to draw.
                //
                future: activities
                    .completedActivities("happyday.mjohnson@gmail.com"),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // The completed activities are available.
                  if (snapshot.connectionState == ConnectionState.done) {
                    return _listViewActivities(false, snapshot.data);
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

  Widget _listViewActivities(bool active, List<Activity> activities) {
    return _makeBody(active, activities);
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
        child: Icon(getIcon(name: activity.icon)),
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
                _updateActivityState(active);
              }),
        ],
      ),
      subtitle: Row(
        children: <Widget>[
          Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(activity.tip,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              )),
        ],
      ),
      trailing: Icon(Icons.keyboard_arrow_right, size: 30.0),
    );
  }

  void _updateActivityState(bool active) async {
    // Update the user's completedActivities list.
    // if active == true, add to completedActivities.
    // if active == false, remove from completed Activities.
    // The update gets written back into the User's json file.
    print('tap state: $active');
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    print(appDocPath);
  }
}
