//
// The goal of this code is to provide the UI showing the amount
// of impact the user has made in equivalency to barrels of oil,
// dollars saved, or the number of trees that would need to be planted
// to absorb the amount of CO2 that has not been released.
//
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';


Widget impactContent(String currentImageURL) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      // TODO: Figure out from the energy meter/datastore
      // how much electricity has been saved.
      _electricitySaved(10),
      // TODO: figuring out and passing the impact amount.
      _impactEquivalent(54,currentImageURL),
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

  Widget _impactEquivalent(int amount,String currentImage) {
    String _assetString;
    String _textString;
    // The category is in the URL being used.
    if (currentImage.contains('tree')) {
      _assetString = 'assets/tree.png';
      _textString = amount.toString() + ' trees';
    } else if (currentImage.contains('oil')) {
      _assetString = 'assets/oil.png';
      _textString = amount.toString() + ' barrels';
    } else {
      _assetString = 'assets/money.png';
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

  
