import 'dart:convert';

import 'package:DeliverMyFood/delivermyfood/Callbacks.dart';
import 'package:DeliverMyFood/delivermyfood/models/City.dart';
import 'package:DeliverMyFood/delivermyfood/models/FoodItemType.dart';
import 'package:DeliverMyFood/delivermyfood/ui/CityGridView.dart';
import 'package:DeliverMyFood/delivermyfood/ui/FoodItemTypeSelectPage.dart';
import 'package:DeliverMyFood/delivermyfood/ui/SearchVenuePage.dart';
import 'package:DeliverMyFood/model/Post.dart';
import 'package:DeliverMyFood/model/RestuarantResp.dart';
import 'package:DeliverMyFood/model/ReviewsResponse.dart';
import 'package:DeliverMyFood/model/data.dart';
import 'package:DeliverMyFood/push_notifications.dart';
import 'package:DeliverMyFood/themes/theme.dart';
import 'package:DeliverMyFood/ui/ListViewDialog.dart';
import 'package:DeliverMyFood/ui/ListViews.dart';
import 'package:DeliverMyFood/ui/ShoppingCartPage.dart';
import 'package:DeliverMyFood/ui/widgets/product_icon.dart';
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

class _RestaurantListScreenState extends State<HomePage> implements OnItemSelect{
  Future<RestaurantResp> data;
  List<String> name = new List();
  List<int> colors = new List();
  String checkoutText = "Checkout";
  int count = 0;
  var fList = foodItemListType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Utils.restaurantList = List();
    //venueName = Utils.selectedVenue;
    data = getData();
    PushNotificationsManager().init();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if(count==0){
            final snackBar = SnackBar(content: Text('Add atleast one item'));
            Scaffold.of(context).showSnackBar(snackBar);
          }else{
            openCheckoutPage();
          }
        },
        label: Text(checkoutText),
        icon: Icon(Icons.shopping_cart),
        backgroundColor: Colors.blue,
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
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: <Widget>[
          _categoryWidget(),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
                            onPressed: () => showTypeSelection(positon,snapshot[positon].restaurant),
                            child: Text(name[positon],style: TextStyle(fontSize: 14),),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(colors[positon]))),
                          ),
                        )),
                  ],
                );
              })
        ],
      ),
    );
  }


  Widget _categoryWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: AppData.categoryList
            .map(
              (category) => ProductIcon(
            model: category,
            onSelected: (model) {
              setState(() {
                AppData.categoryList.forEach((item) {
                  item.isSelected = false;
                });
                model.isSelected = true;
              });
            },
          ),
        )
            .toList(),
      ),
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


  openVenueSearch(City city, NavigatorState of) {
    of.pop();
    //cityName = city.title;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchVenuePage(city: city)),
    );
  }

  showTypeSelection(int position,Restaurant restaurant) {
    setState(() {
      //name.insert(positon, element)
      name[position] = "✔ Added";
      colors[position] = 0xff0080ff;
    });
    return showTypeDialog(position,restaurant);
  }

  @override
  void foodType(FoodItemType foodItemType, int position) {
     debugPrint(""+foodItemType.name+" "+position.toString());
     setState(() {
       Utils.selectedFoodType = foodItemType.index;
     });
  }

  showTypeDialog(int position,Restaurant restaurant) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        int value = 1;
        int tempCount = 0;
        return AlertDialog(
          title: Text("Select option"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 240,
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                          child: Column(
                            children:
                            fList.map((data) => RadioListTile(
                              title: Text("${data.name}"),
                              groupValue: value,
                              value: data.index,
                              onChanged: (val) {
                                setState(() {
                                  debugPrint("printValue: "+data.index.toString());
                                  value = data.index;
                                });
                                //Navigator.pop(context);
                              },
                            )).toList(),
                          ),
                        )),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text("DONE"),
              onPressed: () {
                setState(() {
                  count++;
                  Utils.restaurantList.add(restaurant);
                  checkoutText = "Checkout"+" ("+count.toString()+")";
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void openCheckoutPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShoppingCartPage()),
    );
  }
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
