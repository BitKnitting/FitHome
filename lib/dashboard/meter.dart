import 'dart:async';
// TODO: only one stream across widgets.
class EnergyReading {
  DateTime dateTime;
  int watts;

  EnergyReading(this.watts, this.dateTime);
}

abstract class Meter {
  Meter();
  // A Stream controller alerts the stream when new data is available.
  // The controller should be private.
  // I made the StreamController static so that there would only
  // be one across any widget that used it.  Perhaps there is a 
  // better way.
  static StreamController<EnergyReading> meterStreamController =
      StreamController<EnergyReading>();
  // Expose the stream so a StreamBuilder can use it.
  Stream<EnergyReading> get meterStream => meterStreamController.stream;
  EnergyReading reading;

  void start();
  // TODO: I am not understanding how to use one stream/stream controller
  // across multiple widgets.  All I know is static variables are at the
  // class and not instance level.  Here, I have a mix of a static 
  // streamcontroller and everything else controlling the stream as
  // instances.

  void stop() {
    meterStreamController.close();
  }
}
