import 'package:DeliverMyFood/delivermyfood/models/City.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CityGridView extends StatelessWidget {

  final City city;
  const CityGridView({Key key, this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
        color: Colors.white,
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child:Image.asset(city.icon)),
                Text(city.title, style: TextStyle(fontSize: 10)),
              ]),
        ));
  }
}