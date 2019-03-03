//
// This class extends the MeterReading class to support emulating
// sensor data.  This is for development and testing.
//
import 'dart:async';
import 'dart:math';
import 'energy_data_structure.dart';

class DummyMeter {
  Timer _timer;
  int sampleTime;
  DummyMeter(int sampleTime) {
    this.sampleTime =sampleTime;
  }
  StreamController<EnergyReading> controller;

  void start() {
    _timer = Timer.periodic(Duration(seconds: this.sampleTime), _timerCallBack);
  }

  void stop() {
    _timer.cancel();
  }

  void _timerCallBack(Timer timer) {
    _putEnergyReadingIntoStream();
  }

  void _putEnergyReadingIntoStream() {
    Random rnd = Random();
    EnergyReading reading = EnergyReading(rnd.nextInt(1500), DateTime.now());
    controller.add(reading);
  }
}
