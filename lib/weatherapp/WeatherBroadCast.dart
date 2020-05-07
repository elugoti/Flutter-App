import 'package:firstflutter/weatherapp/Models/Apimodels.dart';
import 'package:firstflutter/weatherapp/UI/bottom_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Network/Network.dart';
import 'UI/mid_view.dart';

class WeatherBroadCast extends StatefulWidget {
  @override
  _WeatherBroadCastState createState() => _WeatherBroadCastState();
}

class _WeatherBroadCastState extends State<WeatherBroadCast> {
  Future<WeatherForecastModel> data;
  String city = "Mumbai";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = weatherData();
    data.then((weather) =>
        {debugPrint("weatherInfo: " + weather.list[0].weather[0].main)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: textInputField(),
          ),
          FutureBuilder<WeatherForecastModel>(
              future: data,
              builder: (BuildContext context,
                  AsyncSnapshot<WeatherForecastModel> snapshot) {
                 if(snapshot.hasData){
                   return Column(
                     children: <Widget>[
                       midView(snapshot),
                       getBottomView(snapshot, context)
                     ],
                   );
                 }else{
                   return Container(
                     child: Center(
                       child: CircularProgressIndicator(),
                     ),
                   );
                 }
              })
        ],
      ),
    );
  }

  Widget textInputField() {
    return Container(
      child: TextField(
        decoration: InputDecoration(
            hintText: "Enter city name",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.all(8)),
        onSubmitted: (value) {
          setState(() {
            city = value;
            data = weatherData();
          });
        },
      ),
    );
  }

  Future<WeatherForecastModel> weatherData() => Network().getWeatherData(city);
}
