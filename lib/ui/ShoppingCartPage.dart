import 'package:DeliverMyFood/model/RestuarantResp.dart';
import 'package:DeliverMyFood/model/data.dart';
import 'package:DeliverMyFood/model/product.dart';
import 'package:DeliverMyFood/themes/light_color.dart';
import 'package:DeliverMyFood/themes/theme.dart';
import 'package:DeliverMyFood/ui/LoginScreen.dart';
import 'package:DeliverMyFood/ui/PaymentScreen.dart';
import 'package:DeliverMyFood/ui/widgets/title_text.dart';
import 'package:DeliverMyFood/weatherapp/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCartPage extends StatelessWidget {
  static int count = 1;

  const ShoppingCartPage({Key key}) : super(key: key);

  Widget _cartItems() {
    return Column(children: Utils.restaurantList.map((x) => _item(x)).toList());
  }

  Widget _item(Restaurant restaurant) {
    return Container(
      height: 80,
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.2,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                color: LightColor.lightGrey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  bottom: -20,
                  child: Image.network(restaurant.thumb),
                )
              ],
            ),
          ),
          Expanded(
              child: Scaffold(
            backgroundColor: LightColor.white,
            body: ListTile(
                title: TitleText(
                  text: restaurant.name,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
                subtitle: Row(
                  children: <Widget>[
                    TitleText(
                      text: '\$ ',
                      color: LightColor.red,
                      fontSize: 12,
                    ),
                    TitleText(
                      text: restaurant.averageCostForTwo.toString(),
                      fontSize: 14,
                    ),
                  ],
                ),
                trailing: Container(
                  width: 35,
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: LightColor.lightGrey.withAlpha(150),
                      borderRadius: BorderRadius.circular(10)),
                  child: TitleText(
                    text: 'x${count}',
                    fontSize: 12,
                  ),
                )),
          ))
        ],
      ),
    );
  }

  Widget _price() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: '${Utils.restaurantList.length} Items',
          color: LightColor.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: '\$${getPrice()}',
          fontSize: 18,
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return FlatButton(
        onPressed: () {
          openPaymentPage(context);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: LightColor.orange,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          width: AppTheme.fullWidth(context) * .7,
          child: TitleText(
            text: 'Checkout',
            color: LightColor.background,
            fontWeight: FontWeight.w500,
          ),
        ));
  }

  double getPrice() {
    double price = 0;
    Utils.restaurantList.forEach((x) {
      price += x.averageCostForTwo;
    });
    return price;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 0),
      child: Scaffold(
        backgroundColor: LightColor.white,
        body: Container(
          padding: AppTheme.padding,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _cartItems(),
                Divider(
                  thickness: 1,
                  height: 70,
                ),
                _price(),
                SizedBox(height: 30),
                _submitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  openPaymentPage(BuildContext context) {
    Future<SharedPreferences> _sharedPreferences;
    _sharedPreferences = SharedPreferences.getInstance();
    _sharedPreferences.then((value) => {
          if (value.getBool("islogin").toString() == "null")
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              )
            }
          else
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentScreen()),
              )
            }
        });
  }
}
