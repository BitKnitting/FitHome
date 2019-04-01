import 'package:flutter/material.dart';

import 'package:fithome/contact/model/comments.dart';
// When the user taps the Submit button and there is text in the comment field, the code
// stores the comment within FitHome's Firestore database.
// Fields include: 1) date/time comment submitted 2) email address of author 3) comment 4) reply (true or false)

class ContactPage extends StatefulWidget {
  ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        AppBar(
          title: Text('Contact Us'),
        ),
        // Input field for user's comment.
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 50, 10.0, 0),
          child: _showMessageUI(),
          //       ],
          //     ),
          //   ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: _showSubmitButton(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _showMessageUI() {
    // To retrieve the text, there must be a TextEditingController as discussed
    // in this flutter doc: https://bit.ly/2YKZmKu
    return TextField(
      controller: myController,
      maxLines: 10,
      decoration: InputDecoration(
        hintText:
            "Please enter your comment here.  We're excited to hear from you!",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }

  Widget _showSubmitButton() {
    return RaisedButton(
      child: Text('Submit'),
      elevation: 8.0,
      color: Colors.blue,
      textColor: Colors.white,
      onPressed: () {
        _doSubmitButtonActions();
      },
    );
  }

  void _doSubmitButtonActions() {
    _writeComment(myController.text);
    myController.text = "";
    _sayThankyou();
    //
  }

  Future<void> _writeComment(String commentToWrite) async {
    if (commentToWrite.length > 0) {
      await Comments().write(commentToWrite);
    }
  }

  void _sayThankyou() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 10.0,
          title: Text("Thank you!"),
          content: Text("Your comments matter.  They help us do better."),
          actions: <Widget>[
            FlatButton(
              child: Text("Done"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
