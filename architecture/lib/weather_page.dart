import 'package:architecture/city_page.dart';
import 'package:architecture/settings_page.dart';
import 'package:architecture/weather_bloc.dart';
import 'package:flutter/material.dart';

class WeatherHomePage extends StatefulWidget {
  WeatherHomePage({Key key}) : super(key: key);

  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final _bloc = WeatherBloc();
  List<Color> _colors = [Colors.purple, Colors.blue];
  List<double> _stops = [0.1, 0.7];
  @override
  void initState() {
    super.initState();
    _bloc.weatherEventSink.add('Karachi');
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: _colors,
        stops: _stops,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Flutter Weather"),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Settings()));
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CityPage()));
              },
            )
          ],
        ),
        // TODO: Handling of metric system conversion is left
        body: StreamBuilder(
          stream: _bloc.weather,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? weatherWidgetBody(snapshot)
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }

  Widget weatherWidgetBody(snapshot) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            snapshot.data.name,
            style: TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            "00:00:00",
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/cloud.png',
                height: 100,
              ),
              Text(
                _bloc.useMetric
                    ? convertToCentigrade(snapshot.data.main.temp)
                        .toStringAsFixed(2)
                    : snapshot.data.main.temp,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Text(
                    convertToCentigrade(snapshot.data.main.tempMin)
                        .toStringAsFixed(2),
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    convertToCentigrade(snapshot.data.main.tempMax)
                        .toStringAsFixed(2),
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
          Text(
            snapshot.data.weather.first.main,
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
          Text(
            snapshot.data.sys.country,
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }

  double convertToCentigrade(double tempInKelvin) {
    return tempInKelvin - 273.15;
  }
}
