import 'package:architecture/weather_bloc.dart';
import 'package:flutter/material.dart';

class CityPage extends StatefulWidget {
  CityPage({Key key}) : super(key: key);

  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  final _bloc = WeatherBloc();
  final _cityTextController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Change City")),
      body: ListTile(
        title: TextFormField(
          controller: _cityTextController,
          decoration: InputDecoration(hintText: "City", labelText: "City"),
        ),
        trailing: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _bloc.weatherEventSink.add(_cityTextController.text);
              Navigator.pop(context);
            }),
      ),
    );
  }
}
