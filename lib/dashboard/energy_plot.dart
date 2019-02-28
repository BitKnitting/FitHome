//
// A widget that builds a timeseries plot of energy readings and the baseline reading.
// The widget should be put into a container.
// TODO: Baseline plot overlaid on energy plot.
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'meter.dart';
import 'dummy_meter.dart';

class EnergyPlot extends StatefulWidget {
  @override
  _EnergyPlotState createState() => _EnergyPlotState();
}

class _EnergyPlotState extends State<EnergyPlot> {
  // Sets up the meter reading stream where incoming meter readings
  // are emulated.
  DummyMeter meter = DummyMeter(sampleTime: 2);
  List<EnergyReading> energyReadings = [];
  Widget energyLine;
  var series;

  @override
  void initState() {
    super.initState();
    // Set up a callback to handle meter readings as they come in.
    // Update the widget's state with the new data.
    Meter.meterStreamController.stream.listen((reading) => setState(() {
          energyReadings.add(reading);
          // Plot 10 readings.
          if (energyReadings.length > 10) {
            energyReadings.removeAt(0);
          }
        }));
    meter.start();
  }

  @override
  Widget build(BuildContext context) {
    _buildXY();
    return SizedBox(
      child: energyLine,
      width: 400.0,
      height: 300.0,
    );
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
