import 'package:flutter/material.dart';
import 'dart:math';
import 'package:transparent_image/transparent_image.dart';
import 'impact_images.dart';
import 'energy_plot.dart';
import 'impact_content.dart';
import 'dart:ui';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Prime the image cache with the images that will
  // be displayed in the background.
  ImpactImages impactImages; // Gets initialized in didChangeDependencies().
  @override
  initState() {
    super.initState();

    // Get images from unsplash that we'll use to display related to impact
    // equivalencies such as money, trees planted, oil barrels not used.
    ImpactImages impactImages = ImpactImages(100.0, 500.0);
    impactImages.impactURLs.forEach((f) => print(f));
  }

  // Precache is called here because of the error message when in initState:
  // initialization based on inherited widgets can be placed in the
  // didChangeDependencies method, which is called after initState and
  // whenever the dependencies change thereafter.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var height = MediaQuery.of(context).size.height;
    print('the screen height is $height');
    var width = MediaQuery.of(context).size.width;
    print('the screen width is $width');
    impactImages = ImpactImages(width, height);
    impactImages.impactURLs.forEach(
        (urlString) => precacheImage(NetworkImage(urlString), context));
  }

  String currentImage;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ////////
        Column(
          children: <Widget>[
            //////
            Expanded(
              child: _impactImage(),
            ),
            //////
            _electricityPlot(),
          ],
        ),
        /////////
        Positioned(
          child: _frostedCard(impactContent(currentImage),
              MediaQuery.of(context).size.height / 7, 182.0, .6),
        ),
        ////////
        _floatingActionButton(),
      ],
    );
  }

// The image invokes a positive emotion about saving electricity and
// be a reminder of an aspect of the environment - trees, oil, money.
// The images come from unsplash categories for trees, oil, money.
//
// TODO: FIX Image does not appear on Android emulator.
//
  Widget _impactImage() {
    Random rnd = Random();
    List<String> placeholderAssets = _getPlaceholderAssets();
    String placeholderAsset =
        placeholderAssets[rnd.nextInt(placeholderAssets.length)];
    ;
    currentImage =
        impactImages.impactURLs[rnd.nextInt(impactImages.impactURLs.length)];
    try {
      return FadeInImage.assetNetwork(
        placeholder: placeholderAsset,
        image: currentImage,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    } catch (e) {
      print('Error loading image: $e');
      return Container(child: Center(child: Text('no image.')));
    }
  }

//
// Add the local images to help with performance when loading
// the network images.
//
  List<String> _getPlaceholderAssets() {
    const List<String> placeholderAssets = [
      'assets/impactImages/3302326_tree_1_shrunk.jpg',
      'assets/impactImages/3302326_tree_2_shrunk.jpg',
      'assets/impactImages/3302326_tree_3_shrunk.jpg',
      'assets/impactImages/3947516_oil_1_shrunk.jpg',
      'assets/impactImages/3947516_oil_2_shrunk.jpg',
    ];

    return placeholderAssets;
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
}
