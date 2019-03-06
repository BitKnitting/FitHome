import 'package:flutter/material.dart';
import 'ToDo_model.dart';

class ToDoPage extends StatelessWidget {
  @override
  // The ToDo page has two tabs.  One for Active ToDos
  // and one for completed ToDos.
  // The highest level being built is the two tabs.
  Widget build(BuildContext context) {
    return ActiveAndCompletedToDos();
  }
}

class ActiveAndCompletedToDos extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ActiveAndCompletedToDos> {
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
    print('********');
    _makeListView();
    return Container(child: Text('hello'));
  }

  _makeListView() async {
    print("***************");
    Map toDos = await loadToDos();
    toDos.forEach((k, v) {
      print('-----> $v');

//      print('Key: $k, Value: $v');
//      print(toDos[v]);
    });

    //print(toDos['ToDos'][0]);
  }
}
