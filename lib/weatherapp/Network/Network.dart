import 'dart:convert';

import 'package:DeliverMyFood/weatherapp/Models/Apimodels.dart';
import 'package:DeliverMyFood/weatherapp/Utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class Network{
  Future<WeatherForecastModel> getWeatherData(String city) async{
    String finalUrl = "https://api.openweathermap.org/data/2.5/forecast/daily?"
        "q="+city+"&appid="+Utils.APPID+"&units=imperial";
    Response response = await get(Uri.encodeFull(finalUrl));
    debugPrint("URL: $finalUrl");
    if(response.statusCode==200){
      //debugPrint(response.body);
      return WeatherForecastModel.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed to fetch weather information");
    }
  }
}