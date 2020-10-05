import 'dart:async';

import 'package:architecture/bloc_example/counter_event.dart';

class CounterBloc {
  CounterBloc() {
    _counterEventController.stream.listen((event) {
      if (event is IncrementEvent) {
        _counter++;
        print(_counter);
      } else {
        _counter--;
        print(_counter);
      }
      _inCounter.add(_counter);
    });
  }
  int _counter = 0;
  final _counterStateController = StreamController<int>();
  StreamSink<int> get _inCounter => _counterStateController.sink;
  Stream<int> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}
