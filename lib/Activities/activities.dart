import 'package:flutter/material.dart';

class ActivitiesPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ActivitiesPage> {
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
          title: Text('ToDO List'),
        ),
        body: TabBarView(
          // One child is a ListView of Active ToDos.
          // The Other is a ListView of Completed ToDos.
          children: [
            Center(child: _listViewOfToDos()),
            Center(child: _listViewOfToDos()),
          ],
        ),
      ),
    );
  }

  // Return the cards for either the active or completed tabs.
  Widget _listViewOfToDos() {
    return Container(child: Text('hello'));
  }
}
