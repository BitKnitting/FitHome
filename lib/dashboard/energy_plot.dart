//
// A widget that builds a timeseries plot of energy readings.
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:async';
import 'meter_stream.dart';
import 'energy_data_structure.dart';

class EnergyPlot extends StatefulWidget {
  @override
  _EnergyPlotState createState() => _EnergyPlotState();
}

class _EnergyPlotState extends State<EnergyPlot> {
  List<EnergyReading> energyReadings = [];
  Widget energyLine;
  var series;
  StreamSubscription<EnergyReading> readingSubscription;

  @override
  void dispose() {
    super.dispose();
    readingSubscription.cancel();

  }
  @override
  void initState() {
    super.initState();
    // Listen to the stream of incoming meter readings.   
    Stream<EnergyReading> readingStream = readings();
    readingSubscription = readingStream.listen(
      (reading) => setState(
            () {
              // Add the reading to the List that gets plotted.
              energyReadings.add(reading);
              // Plot 10 readings.
              if (energyReadings.length > 10) {
                energyReadings.removeAt(0);
              }
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _buildXY();
    return energyLine;
  }

  //
  // Create a time series chart using energy readings.
  // Encapsulates setting up the series and energyLine
  // variables.
  //
  void _buildXY() {
// Set the x/y info of the time series.
    series = [
      charts.Series(
        id: 'Energy Readings',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (EnergyReading reading, _) => reading.dateTime,
        measureFn: (EnergyReading readings, _) => readings.watts,
        data: energyReadings,
      ),
    ];
    // Create a time series chart
    energyLine = charts.TimeSeriesChart(
      series,
      animate: true,
    );
  }
}
