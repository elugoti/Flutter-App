import 'package:firstflutter/model/RestuarantResp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({Key key, this.restaurant}) : super(key: key);

  @override
  _RestaurantDetailPageState createState() =>
      _RestaurantDetailPageState(restaurant);
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  final Restaurant restaurant;

  _RestaurantDetailPageState(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Image.network(
              "${restaurant.photos[0].photo.url}",
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${restaurant.name}",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(top :8.0,bottom: 8.0),
                    child: Text("${restaurant.cuisines}",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top :8.0,bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("🛡️Excellent Hygiene Rating",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal)),
                        Text("🌿 Hyperpure Inside",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal)),
                        Row(
                          children: <Widget>[
                            Text("${restaurant.userRating.aggregateRating}/5",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
