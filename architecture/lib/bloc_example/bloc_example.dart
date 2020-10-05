import 'package:architecture/bloc_example/counter_bloc.dart';
import 'package:architecture/bloc_example/counter_event.dart';
import 'package:flutter/material.dart';

class BlocExample extends StatefulWidget {
  final String title;

  const BlocExample({Key key, this.title}) : super(key: key);
  _BlocExampleState createState() => _BlocExampleState();
}

class _BlocExampleState extends State<BlocExample> {
  final _bloc = CounterBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                snapshot.data.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          );
        },
        stream: _bloc.counter,
        initialData: 0,
      )),
      persistentFooterButtons: [
        FloatingActionButton(
          onPressed: () => _bloc.counterEventSink.add(DecrementEvent()),
          tooltip: 'Decrement--',
          child: Icon(Icons.remove),
        ),
        FloatingActionButton(
          onPressed: () => _bloc.counterEventSink.add(IncrementEvent()),
          tooltip: 'Increment++',
          child: Icon(Icons.add),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.dispose();
  }
}
