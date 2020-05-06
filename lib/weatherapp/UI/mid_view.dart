import 'package:firstflutter/weatherapp/Models/Apimodels.dart';
import 'package:firstflutter/weatherapp/Utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget midView(AsyncSnapshot<WeatherForecastModel> snapshot){
  var foreCastList = snapshot.data.list;
  var cityName = snapshot.data.city.name;
  var country = snapshot.data.city.country;
  var formattedDate = new DateTime.fromMillisecondsSinceEpoch((foreCastList[0].dt)*1000);
  return Container(
    padding: EdgeInsets.all(14),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("$cityName,$country",style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 18
        ),),
        Text("${Utils.getDate(formattedDate)}")
      ],
    ),
  );
}