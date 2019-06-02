import 'package:flutter/material.dart';

const String gMemberCredsRoute = '/member_creds';
const String gMainRoute = '/main_page';
const String gDialogCantVerify = 'We cannot verify your membership.';
const String gDialogExplainLocalCredsNotWorking = 'We have an email and password for you.  However, we can\'t find Membership info in our system';


void gShowErrorDialog(BuildContext context, String title, String body) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(title),
        content: new Text(body),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
