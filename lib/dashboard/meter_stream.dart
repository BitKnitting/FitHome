//
// The pupose of this code is to provide a stream of energy meter readings.
// There are many articles on what a stream is and how to program
// for them.  After I finished this code, I found this article https://bit.ly/2EqO30A
//
import 'dart:async';
// During testing, I am using a dummy meter that sends random
// values every so many seconds.
import 'dummy_meter.dart';
import 'energy_data_structure.dart';

// Return the stream and keep the controller private.
Stream<EnergyReading> readings() {
  // Here I'm using random data that comes in every two seconds based on a timer in DummyMeter
  // Ultimately, the meter will use something like mqtt to get readings.
  DummyMeter meter = DummyMeter(2);
  StreamController<EnergyReading> controller;
  void start() {
    // Set the Meter's controller to this one so that when it
    // adds readings, it is adding to our stream.
    meter.controller = controller;
    meter.start();
  }

  void stop() {
    meter.stop();
    controller.close();
  }

  controller = StreamController<EnergyReading>(
      onListen: start, onPause: stop, onResume: start, onCancel: stop);

  return controller.stream;
}
