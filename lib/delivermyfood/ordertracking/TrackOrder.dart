import 'package:DeliverMyFood/delivermyfood/ordertracking/avatarAndText.dart';
import 'package:DeliverMyFood/delivermyfood/ordertracking/progressBar.dart';
import 'package:DeliverMyFood/delivermyfood/ordertracking/timer.dart';
import 'package:DeliverMyFood/delivermyfood/ordertracking/util.dart';
import 'package:DeliverMyFood/themes/light_color.dart';
import 'package:DeliverMyFood/themes/theme.dart';
import 'package:flutter/material.dart';

class TrackOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Order(),
    );
  }
}

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> with TickerProviderStateMixin {
  // final timerDuration = Duration(milliseconds: 2500);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 40,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'CANCEL',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                'Order#568',
                style:
                TextStyle(color: Color.fromRGBO(0, 0, 0, 0.2), fontSize: 12),
              ),
            ),
            Timer(),
            ProgressBar(),
            SizedBox(height: 50),
            AvatarAndText(),
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: OutlineButton(
                borderSide: BorderSide(width: 1.0, color: FoodColors.Blue),
                color: FoodColors.Blue,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 50),
                      Text(
                        'Call Cook',
                        style: TextStyle(fontSize: 15, color: FoodColors.Blue),
                      ),
                      SizedBox(width: 50),
                      Image.asset(
                        'assets/images/call_cook.png',
                        scale: 2,
                      )
                    ],
                  ),
                ),
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}