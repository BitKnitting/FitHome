//
// This class extends the MeterReading class to support emulating
// sensor data.  This is for development and testing.
//
import 'meter.dart';
import 'dart:async';
import 'dart:math';

class DummyMeter extends Meter {
  Timer _timer;
    int sampleTime=2;
  DummyMeter({this.sampleTime});

  void start() {
    _timer = Timer.periodic(Duration(seconds: sampleTime), _timerCallBack);
  }

  void stop() {
    super.stop();
    _timer.cancel();
  }

  void _timerCallBack(Timer timer) {
    _putEnergyReadingIntoStream();
  }

  void _putEnergyReadingIntoStream() {
    Random rnd = Random();
    EnergyReading reading = EnergyReading(rnd.nextInt(1500), DateTime.now());
    Meter.meterStreamController.add(reading);
  }
}
