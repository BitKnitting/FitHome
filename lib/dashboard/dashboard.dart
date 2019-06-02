import 'package:fithome/Members/member.dart';
import 'package:fithome/State_Management/state_container.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'energy_plot.dart';
import 'impact_content.dart';
import 'dart:ui';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<String> _impactImages;

  @override
  initState() {
    super.initState();

    _impactImages = _getImpactImages();
  }

  String currentImage;
  @override
  Widget build(BuildContext context) {
    Member member = StateContainer.of(context).member;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ////////
            Column(
              children: <Widget>[
                //////
                Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: FutureBuilder(
                        future: member.email,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                        }),
                  ),
                ]),
                Expanded(
                  child: _impactImage(_impactImages),
                ),
                //////
                _electricityPlot(),
              ],
            ),
            /////////
            Positioned(
              child: _frostedCard(
                  impactContent(currentImage),
                  MediaQuery.of(context).size.height / 7,
                  35 + MediaQuery.of(context).size.height / 7,
                  .6),
            ),
            ////////
            _floatingActionButton(),
          ],
        ),
      ),
    );
  }

// The image invokes a positive emotion about saving electricity and
// be a reminder of an aspect of the environment - trees, oil, money.
// The images come from unsplash categories for trees, oil, money.
//
//
  Widget _impactImage(List<String> _impactImages) {
    Random rnd = Random();

    currentImage = _impactImages[rnd.nextInt(_impactImages.length)];
    try {
      return Row(
        children: <Widget>[
          Expanded(
            child: Image.asset(
              currentImage,
              fit: BoxFit.fill,
            ),
          ),
        ],
      );
    } catch (e) {
      print('Error loading image: $e');
      return Container(child: Center(child: Text('no image.')));
    }
  }

// The Floating Action button is displayed on the bottom right of the
// Dashboard. When the user taps on the FAB, a new impact background and
// cards are displayed.
//
  Widget _floatingActionButton() {
    return Positioned(
      bottom: 0.0,
      right: 0.0,
      child: FloatingActionButton(
        elevation: 4.0,
        onPressed: _updateImpacts,
        child: Icon(
          Icons.replay,
        ),
      ),
    );
  }

  void _updateImpacts() {
    setState(() {});
  }

  Widget _electricityPlot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          child: EnergyPlot(),
          height: MediaQuery.of(context).size.height / 5,
          width: MediaQuery.of(context).size.width,
        ),
      ],
    );
  }

  Widget _frostedCard(
      Widget child, double height, double bottom, double opacity) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Frosted rectangle with curved corners.
          ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                height: height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white.withOpacity(opacity),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Prime the image cache with the images that will
  // be displayed in the background.
  List<String> _getImpactImages() {
    const List<String> _impactImages = [
      'assets/impactImages/oil_1.jpeg',
      'assets/impactImages/oil_2.jpeg',
      'assets/impactImages/oil_3.jpeg',
      'assets/impactImages/tree_1.jpeg',
      'assets/impactImages/tree_2.jpeg',
      'assets/impactImages/tree_3.jpeg',
      'assets/impactImages/money_1.jpeg',
      'assets/impactImages/money_2.jpeg',
      'assets/impactImages/money_3.jpeg',
    ];

    return _impactImages;
  }
}
