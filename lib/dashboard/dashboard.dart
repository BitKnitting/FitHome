import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:transparent_image/transparent_image.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:math';
import 'impact_images.dart';
import 'energy_plot.dart';
//import 'package:cached_network_image/cached_network_image.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String currentImage;
//
// The image the user sees as the background of the Dashboard.
// It should invoke a positive emotion about saving electricity and
// be a reminder of an aspect of the environment - trees, oil, money.
// The images come from unsplash categories for trees, oil, money.
//
  Widget _impactBackground() {
    Random rnd = Random();
    currentImage =
        ImpactImages.impactURLs[rnd.nextInt(ImpactImages.impactURLs.length)];
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: currentImage,
      fit: BoxFit.fill,
      width: double.infinity, //add this
      height: double.infinity,
    );
  }

  void _updateImpacts() {
    setState(() {});
  }

//
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

  Widget _impactContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // TODO: Figure out from the energy meter/datastore
        // how much electricity has been saved.
        _electricitySaved(10),
        // TODO: figuring out and passing the impact amount.
        _impactEquivalent(54),
        // TODO: Figure out from datastore what
        // ranking user is at for different leaderboard
        // lists.
        _leaderboardRanking(),
      ],
    );
  }

  Widget _electricitySaved(int percentage) {
    return CircularPercentIndicator(
      radius: 50.0,
      lineWidth: 8.0,
      animation: true,
      percent: percentage.toDouble() / 15.0,
      animateFromLastPercent: true,
      center: new Text(
        percentage.toString() + '%',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
      ),
      footer: new Text(
        "Less",
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Colors.green,
    );
  }

  Widget _impactEquivalent(int amount) {
    String _assetString;
    String _textString;
    // The category is in the URL being used.
    if (currentImage.contains(ImpactImages.TREES.toString())) {
      _assetString = 'assets/' + ImpactImages.TREES.toString() + '.png';
      _textString = amount.toString() + ' trees';
    } else if (currentImage.contains(ImpactImages.OIL.toString())) {
      _assetString = 'assets/' + ImpactImages.OIL.toString() + '.png';
      _textString = amount.toString() + ' barrels';
    } else {
      _assetString = 'assets/' + ImpactImages.MONEY.toString() + '.png';
      _textString = '\$' + amount.toString();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(_assetString),
        Text(
          _textString,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ],
//
    );
  }

  Widget _leaderboardRanking() {
    return SizedBox(
      width: 100.0,
      height: 80.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Rank',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Local: 55',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'State: 103',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Overall: 230',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

// The line plot has two plot lines.  Both our
// measurements of watts/time.
// - The baseline - this is a constant value we
//   got measuring how much electricity was being used
//   before the user started conserving.
// - The current - this is the current watts reading.  We
//   update this when there is a new value.
  Widget _impactLinePlot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        EnergyPlot(),
      ],
    );
  }

//
// Card holding Dashboard information.
//
  Widget _frostedCard(Widget child, double bottom) {
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
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width,
                color: Colors.white.withOpacity(.3),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _impactBackground(),
        _frostedCard(_impactContent(), 182.0),
        _frostedCard(_impactLinePlot(), 1.0),
        _floatingActionButton(),
      ],
    );
  }
}
