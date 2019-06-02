//**************************************************************** */
// MemberVerificationPage is UI to get the email and password.  This screen
// occurs if a local value for email and password don't exist OR
// we can't authenticate the member's email/password that is stored
// locally with Firebase.
//**************************************************************** */
import 'package:fithome/Members/member.dart';
import 'package:fithome/State_Management/state_container.dart';
import 'package:fithome/root_page.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:email_validator/email_validator.dart';

import '../globals.dart';

class MemberVerificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MemberVerificationState();
}

class _MemberVerificationState extends State<MemberVerificationPage> {
  Logger log = Logger('member_verification_page.dart');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const String pageTitle = "Verify Membership";
    Member member = StateContainer.of(context).member;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
        ),
        body: Container(
          child: Form(
            key: _formKey,
            autovalidate: true,
            child: ListView(
              children: <Widget>[
                _showLogo(),
                _showExplanatoryText(),
                _showEmailInput(member),
                _showPasswordInput(member),
                _showButton(member),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showLogo() {
    return Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 50.0,
          child: Image.asset('assets/fithome_icon.png'),
        ),
      ),
    );
  }

  Widget _showExplanatoryText() {
    Member member = StateContainer.of(context).member;
    return Padding(
        padding: EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 0.0),
        child: Text(
          member.explanatoryText,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ));
  }

  Widget _showEmailInput(Member member) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 100.0, 50.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) =>
            !EmailValidator.validate(value) ? 'Not a valid email.' : null,
        onSaved: (value) => member.email = value,
      ),
    );
  }

  Widget _showPasswordInput(Member member) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 50.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) =>
            value.length < 6 ? 'Password must be at least 6 characters' : null,
        onSaved: (value) => member.password = value,
      ),
    );
  }

  Widget _showButton(Member member) {
    return new Padding(
        padding: EdgeInsets.fromLTRB(55.0, 45.0, 50.0, 0.0),
        child: new MaterialButton(
          elevation: 5.0,
          minWidth: 200.0,
          height: 42.0,
          color: Colors.blue,
          textColor: Colors.white,
          child: Text('Sign In',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          onPressed: () => _validateAndSubmit(member),
        ));
  }

  // ********************************************************
  // validate the fields and log into Firebase
  void _validateAndSubmit(Member member) async {
    if (_validateAndSave()) {
      member.signIn().then((memberID) {
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RootPage()));
        });
      });
    }
  }

// ********************************************************
// Check to make sure the email and password are entered correctly.
  bool _validateAndSave() {
    // Check if form is valid before performing login or signup
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      return true;
    }
    return false;
  }
}
