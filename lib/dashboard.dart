import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'package:transparent_image/transparent_image.dart';
import 'package:percent_indicator/percent_indicator.dart';
//import 'package:cached_network_image/cached_network_image.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
   @override
  // void initState() {
  //   super.initState();
  //   _getURLs();
  //   precacheImage(NetworkImage('http'),context);
  // }
  // Grab URLs that go to unsplash photos of the impact categories.
  void _getURLs() {

  }
  int _impactCategory;
  static const int TREES = 3302326;
  static const int OIL = 3947516;
  static const int MONEY = 2364459;
  // the _currentImpact is an unsplash collection id for a collection of:
  // forest (3302326)
  // oil (3947516) // money (2364459)
  // Get an image from unsplash that is for one of the impact categories.
  String _getImpactImageURL() {
// mapImpactType is a dictionary where the key is the unsplash
// collection id and the value is the number of images in the
// trees (3302326)
// oil (3947516)
// money (2364459)
// These images provide the backdrop for the impact section of
// the dashboard.

    var mapImpactType = {TREES: 264, OIL: 18, MONEY: 22};
    _impactCategory = mapImpactType.keys
        .elementAt(new Random().nextInt(mapImpactType.length));
    int numImages = mapImpactType[_impactCategory];

    Random rnd = Random();
    int randomImage = 1 + rnd.nextInt(numImages);
    return ("https://source.unsplash.com/collection/" +
        _impactCategory.toString() +
        "/540x960?/sig=" +
        randomImage.toString());
  }

  // use network cache when getting images from unsplash.
  // Widget _backgroundImpactImage() {
  //   _getImpactImages();
  //   return CachedNetworkImage(
  //     //placeholder:CircularProgressIndicator(),
  //     imageUrl: urlStrings[_selectedImageIndex],
  //   );
  // }
//
// The image that the user sees as the background of the Dashboard.
// It should invoke a positive emotion about saving electricity and
// be a reminder of an aspect of the environment - trees, oil, money.
// The images come from unsplash categories for trees, oil, money.
//
  Widget _impactBackground() {
    String urlString = _getImpactImageURL();
// TODO: Several times when I click the FAB to get a new
// image, nothing happens.  I don't know if there is an error
// or what else might have happened.
//
// TODO: Many times loading the image takes too much time for a
// responsive app.  I do not understand lazy loading of images and
// how to apply that here.

    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: urlString,
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
// impact card are displayed.
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

//
// The impact card sits on top of the impact background and gives the
// user info on their impact relative to which background is showing, e.g.:
// if trees are showing, the equivalent number of trees planted is shown.
// There are three pieces of info:
// - The percentage of electricity the user is currently saving relative to
//   the amount of electricity they were using before they starting practicing
//   saving energy.
// - The impact the user is making in equivalent trees, money saved, or barrels
//   of oil not used.  Which one depends on which background image is being shown.
// - The user's leaderboard ranking.
//
//
// TODO: Load after the background image has loaded.
// TODO: Get rid of _linePlotCard and just use _frostedCard w/
// parameter for height (the only difference).
  Widget _impactCard(Widget child) {
// Using the Column for placement in the center.
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 182.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Frosted rectangle with curved corners.
          ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 8,
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

  Widget _impactContent() {
    // TODO: put the content together for the impact card.
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
    switch (_impactCategory) {
      case TREES:
        _assetString = 'assets/' + TREES.toString() + '.png';
        _textString = amount.toString() + ' trees';
        break;
      case OIL:
        _assetString = 'assets/' + OIL.toString() + '.png';
        _textString = amount.toString() + ' barrels';
        break;
      case MONEY:
        _assetString = 'assets/' + MONEY.toString() + '.png';
        _textString = '\$' + amount.toString();
        break;
      default:
        break;
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

  Widget _impactLinePlot() {
    // TODO: Build the line plot.
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("TBD"),
      ],
    );
  }

// TODO: Line plot of current electricity use.
// The line plot has two plot lines.  Both our
// measurements of watts/time.
// - The baseline - this is a constant value we
//   got measuring how much electricity was being used
//   before the user started conserving.
// - The current - this is the current watts reading.  We
//   update this when there is a new value.
  Widget _linePlotCard(Widget child) {
// Using the Column for placement in the center.
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 1.0),
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
        _impactCard(_impactContent()),
        _linePlotCard(_impactLinePlot()),
        _floatingActionButton(),
      ],
    );
  }
}
