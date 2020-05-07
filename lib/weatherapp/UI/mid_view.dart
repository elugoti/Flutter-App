import 'package:firstflutter/weatherapp/Models/Apimodels.dart';
import 'package:firstflutter/weatherapp/Utils/Utils.dart';
import 'package:firstflutter/weatherapp/Utils/convertor_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget midView(AsyncSnapshot<WeatherForecastModel> snapshot) {
  var foreCastList = snapshot.data.list;
  var cityName = snapshot.data.city.name;
  var country = snapshot.data.city.country;
  var formattedDate =
      new DateTime.fromMillisecondsSinceEpoch((foreCastList[0].dt) * 1000);
  return Container(
    padding: EdgeInsets.all(14),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "$cityName,$country",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 18),
        ),
        Text("${Utils.getDate(formattedDate)}"),
        SizedBox(
          height: 10,
        ),
        getIconConvertor(description : "${foreCastList[0].weather[0].main}",color: Colors.pink,size: 198),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "${foreCastList[0].temp.day.toStringAsFixed(0)} °F",
                style: TextStyle(color: Colors.black87,fontSize: 24,fontWeight: FontWeight.w400),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text("${foreCastList[0].weather[0].description.toUpperCase()}",textAlign: TextAlign.center,),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text("${foreCastList[0].speed.toStringAsFixed(1)} m/hr"),
                    Icon(FontAwesomeIcons.wind,color: Colors.brown,size: 20,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text("${foreCastList[0].humidity} %"),
                    Icon(FontAwesomeIcons.hotTub,color: Colors.brown,size: 20,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text("${foreCastList[0].temp.max.toStringAsFixed(0)} °F"),
                    Icon(FontAwesomeIcons.temperatureHigh,color: Colors.brown,size: 20,)
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
