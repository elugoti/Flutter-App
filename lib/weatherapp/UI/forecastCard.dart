import 'package:firstflutter/weatherapp/Models/Apimodels.dart';
import 'package:firstflutter/weatherapp/Utils/Utils.dart';
import 'package:firstflutter/weatherapp/Utils/convertor_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget forecastCard(AsyncSnapshot<WeatherForecastModel> snapshot,int index){
  var forecastList = snapshot.data.list;
  var dayOfWeek = "";
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(forecastList[index].dt*1000);
  var strDate = Utils.getDate(dateTime);
  dayOfWeek = strDate.split(",").elementAt(0);
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text("$dayOfWeek")),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 33,
            backgroundColor: Colors.white,
            child: getIconConvertor(description: forecastList[index].weather[0].main,color:Colors.pinkAccent,size: 45),

          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("${forecastList[index].temp.min} °F"),
                  Icon(FontAwesomeIcons.arrowCircleDown,size: 16,color: Colors.white,)
                ],
              ),
              Row(
                children: <Widget>[
                  Text("${forecastList[index].temp.max} °F"),
                  Icon(FontAwesomeIcons.arrowCircleUp,size: 16,color: Colors.white,)
                ],
              ),
              Text("Hum ${forecastList[index].humidity.toString()} %"),
              Text("Win ${forecastList[index].speed.toStringAsFixed(1)} mi/h"),
            ],
          )
        ],
      )
    ],
  );
}