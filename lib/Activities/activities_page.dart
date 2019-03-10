import 'package:flutter/material.dart';
import 'model/activities_schema.dart';
import 'model/activities_Services.dart';
import '../icons/icon_loader.dart';

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
                    return _listViewActivities(snapshot.data);
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
                  // The active activities are available.
                  if (snapshot.connectionState == ConnectionState.done) {
                    return _listViewActivities(snapshot.data);
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

  Widget _listViewActivities(activities) {
    return _makeBody(activities);
  }

  Widget _makeBody(List<Activity> activities) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: activities.length,
        itemBuilder: (BuildContext context, int index) {
          return _makeCard(activities[index]);
        },
      ),
    );
  }

  Widget _makeCard(Activity activity) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: _makeListTile(activity),
      ),
    );
  }

  Widget _makeListTile(Activity activity) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(
          width: 1.0,
        ))),
        child: Icon(getIcon(name:activity.icon)),
      ),
      title: Text(
        activity.name,
        style: TextStyle(fontWeight: FontWeight.bold),
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
}
