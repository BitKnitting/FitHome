
// Check out Flutter by Example, Log In Flow Boiler Plate  http://bit.ly/2XjLiGA

import 'package:flutter/material.dart';
import 'dashboard/dashboard.dart';
import 'Activities/activities_page.dart';
import 'contact/contact_page.dart';
import 'package:logging/logging.dart';
import 'globals.dart';


class MainPage extends StatefulWidget {
  MainPage({this.title});
  final String title;

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<MainPage> {
  // which screen is currently being displayed - Dashboard, ToDo...
  int _currentPage = 0;
  final List<Widget> _pages = [
    DashboardPage(),
    ActivitiesPage(),
    ContactPage()
  ];
  Logger log = Logger('main_page.dart');
  @override
  void initState() {
    super.initState();
    _logMemberIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SafeArea(
        child: _pages[_currentPage],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPage,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Dashboard'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.star),
            title: new Text('To Dos'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Contact Us'),
          ),
        ],
      ),
    );
  }

//
// When the user taps on one of the tabs on the bottom nav bar, which tab
// is tapped is passed in (as the index variable).  We update our knowledge
// of what screen is currently being displayed
//
  void onTabTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

//********************************************************** */
// Give access to the member.  If the account does not exist, it will
// be created.  A login dialog box will be shown if the creds in the
// local store can't authenticate to Firebase.

  Future<void> _logMemberIn() async {
    // Get creds (if they exist) from the local store.
    // bool memberHasLocalCreds = await Member().isCredsInLocalStore();
    // // if there aren't creds stored locally, bring up UI to get the email and password.
    // if (!memberHasLocalCreds) {
    //   log.info('credentials are not in local store');
    //   Navigator.pushNamed(context, gMemberCredsRoute);
    //   memberHasLocalCreds = await Member().isCredsInLocalStore();
    // }
    // // We're all set with a locally stored email and password. Now it's time to authenticate.
    // log.info('credentials in local store');
    // bool isMemberSignedIn = false;
    // isMemberSignedIn = await Member().signIn();
    // log.info('isMemberSignedIn: $isMemberSignedIn');
    // if (!isMemberSignedIn) {
    //   gShowErrorDialog(
    //       context, gDialogCantVerify, gDialogExplainLocalCredsNotWorking);
    //   Navigator.pushNamed(context, gMemberCredsRoute);
    // }
    // if (isMemberSignedIn) {
    //   Navigator.pushNamed(context, gMainRoute);
    // }
  }
}
