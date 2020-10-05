import 'package:architecture/weather_bloc.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _bloc = WeatherBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text("Temperature Units"),
          subtitle: Text("Use metric measurements for temperature units"),
          trailing: StreamBuilder(
            stream: _bloc.metric,
            initialData: true,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Switch(
                onChanged: (value) {
                  _bloc.metricEventSink.add(value);
                },
                value: snapshot.data,
              );
            },
          ),
        ),
      ),
    );
  }
}
