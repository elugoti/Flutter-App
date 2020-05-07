import 'package:firstflutter/weatherapp/Models/Apimodels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'forecastCard.dart';

Widget getBottomView(
    AsyncSnapshot<WeatherForecastModel> snapshot, BuildContext context) {
  var forecastList = snapshot.data.list;
  return Column(
    children: <Widget>[
      Text(
        "7-Day Weather Forecast".toUpperCase(),
        style: TextStyle(color: Colors.black54, fontSize: 14),
      ),
      Container(
        height: 170,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(
            width: 8,
          ),
          itemCount: forecastList.length,
          itemBuilder: (context,index) => ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
              width: MediaQuery.of(context).size.width/2.5,
              height: 160,
              child: forecastCard(snapshot,index),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff9661C3),Colors.white],
                  begin: Alignment.topLeft,end: Alignment.bottomRight
                )
              ),
            ),
          ),
        ),
      )
    ],
  );
}
