import 'dart:convert';

import 'package:DeliverMyFood/delivermyfood/models/City.dart';
import 'package:DeliverMyFood/delivermyfood/ui/CityGridView.dart';
import 'package:DeliverMyFood/delivermyfood/ui/SearchVenuePage.dart';
import 'package:DeliverMyFood/model/Post.dart';
import 'package:DeliverMyFood/model/RestuarantResp.dart';
import 'package:DeliverMyFood/model/ReviewsResponse.dart';
import 'package:DeliverMyFood/ui/ListViewDialog.dart';
import 'package:DeliverMyFood/ui/ListViews.dart';
import 'package:DeliverMyFood/weatherapp/UI/RestaurantDetailPage.dart';
import 'package:DeliverMyFood/weatherapp/Utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<HomePage>
    with WidgetsBindingObserver {
  Future<RestaurantResp> data;
  List<String> name = new List();
  List<int> colors = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    //venueName = Utils.selectedVenue;
    data = getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("came back");
    if (state == AppLifecycleState.paused) {
      // went to Background
      print("going background");
      setState(() {
        //venueName = Utils.selectedVenue;
      });
    }
    if (state == AppLifecycleState.resumed) {
      // came back to Foreground
      print("resumed");
      setState(() {
        //venueName = Utils.selectedVenue+", "+cityName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffCB202D),
        leading: new IconButton(
          icon: new Icon(Icons.my_location),
          onPressed: () {},
        ),
        title: Text(
          Utils.selectedVenue,
          style: (TextStyle(fontSize: 14)),
        ),
        actions: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 0, top: 0, right: 20, bottom: 0),
            child: IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Show Snackbar',
              onPressed: () {
                if (Utils.city != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchVenuePage(city: Utils.city)),
                  );
                }
              },
            ),
          ),
        ],
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
    String url = Utils.BASE_URL +
        "search?entity_id=259&entity_type=city&start=0&count=20";
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
            String nm = "➕ ADD";
            int color = 0xffCB202D;
            name.add(nm);
            colors.add(color);
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
                      width: 100,
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            //name.insert(positon, element)
                            name[positon] = "✔ Added";
                            colors[positon] = 0xff0080ff;
                          });
                        },
                        child: Text(name[positon]),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(colors[positon]))),
                      ),
                    )),
              ],
            );
          }),
    );
  }

  openRestaurantDetailPage(Restaurant restaurant, BuildContext context) {}

  void fetchMenu(Restaurants snapshot) {
    String url = Utils.BASE_URL +
        "reviews?res_id=" +
        snapshot.restaurant.r.resId.toString() +
        "&start=0&count=20";
    _displayDialog();
  }

  _displayDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Selecy Your City',
              style: TextStyle(color: Colors.redAccent, fontSize: 14),
            ),
            content: Container(
                width: double.maxFinite,
                height: 300.0,
                child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(cities.length, (index) {
                      return Center(
                        child: GestureDetector(
                            onTap: () => openVenueSearch(
                                cities[index], Navigator.of(context)),
                            child: CityGridView(city: cities[index])),
                      );
                    }))),
            actions: <Widget>[
//              new FlatButton(
//                child: new Text(''),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//              )
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
          Image.network(
            "${user.profileImage}",
            width: 40,
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${user.name}",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Text(
                    "${data.review.reviewText}",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  openVenueSearch(City city, NavigatorState of) {
    of.pop();
    //cityName = city.title;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchVenuePage(city: city)),
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
                title: Text("hello"),
              )
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
