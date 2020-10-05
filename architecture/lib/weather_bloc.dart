import 'dart:async';
import 'package:architecture/weather_service.dart';

import 'weather_model.dart';

class WeatherBloc {
  static final WeatherBloc _singleton = WeatherBloc._internal();

  factory WeatherBloc() => _singleton;

  WeatherBloc._internal() {
    _weatherEventController.stream.listen((cityName) async {
      WeatherResponse res = await WeatherService.getWeatherData(cityName);
      _inWeather.add(res);
    });
    _metricEventController.stream.listen((shouldUseMetric) {
      _inMetric.add(shouldUseMetric);
    });
  }
  WeatherResponse weatherResponse;
  final _weatherStateController = StreamController<WeatherResponse>();
  StreamSink<WeatherResponse> get _inWeather => _weatherStateController.sink;
  Stream<WeatherResponse> get weather => _weatherStateController.stream;
  final _weatherEventController = StreamController<String>();
  Sink<String> get weatherEventSink => _weatherEventController.sink;

  bool useMetric = true;
  final _metricStateController = StreamController<bool>();
  StreamSink<bool> get _inMetric => _metricStateController.sink;
  Stream<bool> get metric => _metricStateController.stream;
  final _metricEventController = StreamController<bool>();
  Sink<bool> get metricEventSink => _metricEventController.sink;

  void dispose() {
    _weatherStateController.close();
    _weatherEventController.close();
    _metricStateController.close();
    _metricEventController.close();
  }
}
