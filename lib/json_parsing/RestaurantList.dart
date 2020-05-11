import 'dart:convert';

import 'package:firstflutter/model/Post.dart';
import 'package:firstflutter/model/RestuarantResp.dart';
import 'package:firstflutter/model/ReviewsResponse.dart';
import 'package:firstflutter/ui/ListViewDialog.dart';
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
    String url = Utils.BASE_URL+"search?entity_id=259&entity_type=city&start=0&count=20";
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
                     fetchMenu(snapshot[positon]);
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

  void fetchMenu(Restaurants snapshot) {
    String url= Utils.BASE_URL + "reviews?res_id="+snapshot.restaurant.r.resId.toString()+"&start=0&count=20";
    Network network = Network(url);
    network.fetchReviews().then((onValue) => {
        debugPrint(onValue.toString()),
       _displayDialog(onValue.userReviews)
    });

  }

  void showDialogView(List<UserReviews> userReviews) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title:  Text("Reviews"),
          content: Container(
            child: Column(
              children: <Widget>[

              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  _displayDialog(List<UserReviews> userReviews)  {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Reviews',style: TextStyle(color: Colors.blueGrey,fontSize: 18),),
            content: Container(
              width: double.maxFinite,
              height: 500.0,
              child: ListView(
                padding: EdgeInsets.all(8.0),
                //map List of our data to the ListView
                children: userReviews.map((data) => reviewInfo(data)).toList(),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CLOSE'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget reviewInfo(UserReviews data) {
    var user = data.review.user;
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.network("${user.profileImage}",width: 40,height: 40,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("${user.name}",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 14),),
                Container(
                  width: MediaQuery.of(context).size.width*0.45,
                  child:Text("${data.review.reviewText}",style: TextStyle(color: Colors.grey,fontSize: 12),maxLines: 3,overflow: TextOverflow.ellipsis,),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget showReviewUI(BuildContext context, List<UserReviews> list) {

  return Container(
    child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, int positon) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Divider(height: 5.0),
              ListTile(
                  title: Text("hello"),)
            ],
          );
        }),
  );
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
  Future<ReviewsResponse> fetchReviews() async {
    Response response = await get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return ReviewsResponse.fromJson(json.decode(response.body));
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
