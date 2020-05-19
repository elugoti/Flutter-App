
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class City {
  const City({this.title, this.icon});
  final String title;
  final String icon;
}

const List<City> cities = [
  City(title: 'Agra', icon: "images/agra.png"),
  City(title: 'Bengaluru', icon: "images/bengaluru.png"),
  City(title: 'Chennai', icon: "images/chennai.png"),
  City(title: 'Delhi', icon: "images/delhi.png"),
  City(title: 'Hyderabad', icon: "images/hyderabad.png"),
  City(title: 'Kolkata', icon: "images/kolkata.png"),
  City(title: 'Lucknow', icon: "images/lucknow.png"),
  City(title: 'Mumbai', icon: "images/mumbai.png"),
  City(title: 'Vizag', icon: "images/vizag.png"),
];