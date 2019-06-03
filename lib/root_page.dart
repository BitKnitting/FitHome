import 'package:fithome/Members/member_verification_page.dart';
import 'package:fithome/State_Management/state_container.dart';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:fithome/main_page.dart';
import 'Members/member.dart';

enum AuthStatus { unknown, notSignedIn, signedIn }

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  Logger log = Logger('root_page.dart');
  AuthStatus authStatus = AuthStatus.unknown;
  @override
  // didChangeDependencies is not an async method.  Using .then as
  // advices in Andrea Bizzoto's video: http://bit.ly/30WPYEt
  void didChangeDependencies() {
    super.didChangeDependencies();
    Member member = StateContainer.of(context).member;
    member.signIn().then((memberID) {
      setState(() {
        authStatus =
            memberID == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    log.info('authStatus: $authStatus');
    switch (authStatus) {
      case AuthStatus.unknown:
        return _loadingView();
      case AuthStatus.notSignedIn:
        return MemberVerificationPage();
      case AuthStatus.signedIn:
        return MainPage();
    }
    return null;
  }

  Widget _loadingView() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
