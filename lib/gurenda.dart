import 'package:rxdart/rxdart.dart';
import "dart:math" show pi;
import 'package:aeyrium_sensor/aeyrium_sensor.dart';

double pitchToDegree(SensorEvent event) => event.pitch * 180 / pi;

class GurendaResult {
  bool success;
  GurendaProcessValue value;

  GurendaResult(this.success, [this.value]);
}

class GurendaProcessValue {
  double acc;
  double previousDegree;

  GurendaProcessValue(this.acc, this.previousDegree);
}

class Gurenda {
  Future<Observable<GurendaResult>> start() async {
    double startDegree = await this.getDegree();
    var timeout = Observable.timer(new GurendaResult(false), const Duration(seconds: 10));
    var events = new Observable(AeyriumSensor.sensorEvents)
      .throttleTime(const Duration(milliseconds: 50))
      .map(pitchToDegree)
      .scan<GurendaProcessValue>((process, degree, _) {
        var diff = (process.previousDegree - degree).abs();
        return new GurendaProcessValue(process.acc + diff, degree);
      }, new GurendaProcessValue(0, startDegree))
      .skipWhile((value) => value.acc <= 340)
      .take(1)
      .map((value) => new GurendaResult(true, value));

    return Observable.race([timeout, events]);
  }

  Future<double> getDegree() {
    return new Observable(AeyriumSensor.sensorEvents)
        .take(1)
        .map(pitchToDegree)
        .first;
  }
}
