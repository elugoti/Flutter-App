import 'dart:convert';

import 'package:firstflutter/model/Post.dart';
import 'package:firstflutter/model/RestuarantResp.dart';
import 'package:firstflutter/ui/ListViews.dart';
import 'package:firstflutter/weatherapp/UI/RestaurantDetailPage.dart';
import 'package:firstflutter/weatherapp/Utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

class RestaurantListScreen extends StatefulWidget {
  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  Future<RestaurantResp> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffCB202D),
        title: Text("Restaurants"),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
              future: data,
              builder: (context, AsyncSnapshot<RestaurantResp> snapshot) {
                if (snapshot.hasData) {
                  return showListViewData(context, snapshot.data.restaurants);
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }

  Future<RestaurantResp> getData() {
    String url =
        "https://developers.zomato.com/api/v2.1/search?entity_id=259&entity_type=city&start=0&count=20";
    var data;
    Network network = new Network(url);
    data = network.fetchData();
    //print(data);
    return data;
  }

  Widget showListViewData(BuildContext context, List<Restaurants> snapshot) {
    return Container(
      child: ListView.builder(
          itemCount: snapshot.length,
          itemBuilder: (context, int positon) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Divider(height: 5.0),
                ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RestaurantDetailPage(
                                    restaurant: snapshot[positon].restaurant,
                                  )));
                    },
                    leading: Column(
                      children: <Widget>[
                        Image.network("${snapshot[positon].restaurant.thumb}",
                            width: 50, height: 50),
                      ],
                    ),
                    title: Text("${snapshot[positon].restaurant.name}"),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("🍚 ${snapshot[positon].restaurant.cuisines}",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                              overflow: TextOverflow.ellipsis),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.dollarSign,
                                  size: 14,
                                  color: Colors.blue,
                                ),
                                Text(
                                    "Cost for two \$${snapshot[positon].restaurant.averageCostForTwo}")
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    trailing: Container(
                      width: 50,
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "${snapshot[positon].restaurant.userRating.aggregateRating} ⭐",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
              ],
            );
          }),
    );
  }

  openRestaurantDetailPage(Restaurant restaurant, BuildContext context) {}
}

class Network {
  final String url;

  Network(this.url);

  Future<RestaurantResp> fetchData() async {
    debugPrint("$url");
    Response response = await get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return RestaurantResp.fromJson(json.decode(response.body));
    } else {
      debugPrint("${response.statusCode}");
    }
  }

  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "user-key": Utils.API_KEY,
      };
}
