import 'package:architecture/notifier_example/counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotifierExample extends StatefulWidget {
  NotifierExample({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _NotifierExampleState createState() => _NotifierExampleState();
}

class _NotifierExampleState extends State<NotifierExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer<Counter>(
              builder: (context, counter, child) => Text(
                '${counter.value}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        FloatingActionButton(
          onPressed: () =>
              Provider.of<Counter>(context, listen: false).decrement(),
          tooltip: 'Decrement',
          child: Icon(Icons.remove),
        ),
        FloatingActionButton(
          onPressed: () =>
              Provider.of<Counter>(context, listen: false).increment(),
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}
