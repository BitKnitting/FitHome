import 'package:fithome/Activities/model/activities.dart';
import 'package:fithome/Users/user.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChecklistPage extends StatefulWidget {
  final Activity activity;

  const ChecklistPage({Key key, @required this.activity}) : super(key: key);
  @override
  _ChecklistPageState createState() => _ChecklistPageState(activity);
}

class _ChecklistPageState extends State<ChecklistPage> {
  List<bool> _isChecked = [];
  Activity activity;
  _ChecklistPageState(this.activity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checklist for ${activity.name}"),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.keyboard_arrow_left, size: 30.0),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }),
      ),
      body: _listViewChecklist(activity.checklist),
    );
  }

  Widget _listViewChecklist(List<Checklist> checklist) {
    return _makeBody(checklist);
  }

  Widget _makeBody(List<Checklist> checklist) {
    return Container(
      child: FutureBuilder(
          future: User.getChecklistCompletes(
              activity.name, activity.checklist.length),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              snapshot.data.forEach((todo) => _isChecked.add(todo));

              return ListView.builder(
                  itemCount: checklist.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return _makeCard(
                        index, checklist[index].todo, checklist[index].url);
                  });
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Widget _makeCard(int index, String todo, String url) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
          child: CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: _displayToDo(index),
              value: _isChecked[index],
              activeColor: Colors.green,
              // secondary: const Icon(Icons.home),
              onChanged: (bool value) {
                setState(() {
                  _isChecked[index] = value;
                  User.updateChecklistCompletes(activity.name, _isChecked);
                });
              })),
    );
  }

  Widget _displayToDo(int index) {
    TextDecoration toDoTextDecoration;

    if (activity.checklist[index].url.length > 0) {
      return GestureDetector(
        child: Text(
          activity.checklist[index].todo,
          style: TextStyle(
              decoration: _isChecked[index]
                  ? TextDecoration.lineThrough
                  : TextDecoration.underline,
              color: Colors.blue),
        ),
        onTap: () {
          _launchURL(activity.checklist[index].url);
        },
      );
    }
    //if there is now url, display text.
    return Text(activity.checklist[index].todo,
        style: TextStyle(
            decoration: _isChecked[index]
                ? TextDecoration.lineThrough
                : TextDecoration.none));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
