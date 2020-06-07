import 'package:flutter/material.dart';

class Oder_History extends StatefulWidget {
  final String toolbarname;

  Oder_History({Key key, this.toolbarname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => oder_history(toolbarname);
}

class Item {
  final String name;
  final String deliveryTime;
  final String oderId;
  final String oderAmount;
  final String paymentType;
  final String address;
  final String cancelOder;

  Item(
      {this.name,
        this.deliveryTime,
        this.oderId,
        this.oderAmount,
        this.paymentType,
        this.address,
        this.cancelOder});
}

class oder_history extends State<Oder_History> {
  List list = ['12', '11'];
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;
  VoidCallback _showBottomSheetCallback;
  List<Item> itemList = <Item>[
    Item(
        name: 'Krishna Reddy E',
        deliveryTime: '26-05-2020',
        oderId: '#CN23656',
        oderAmount: '\₹ 650',
        paymentType: 'PAYTM',
        address: 'PVR Cinemas, Lumbini Avenue, Gachibowli',
        cancelOder: 'Cancel Order'),
    Item(
        name: 'Ramu Reddy E',
        deliveryTime: '10-08-2019',
        oderId: '#CN33568',
        oderAmount: '\₹ 900',
        paymentType: 'PHONEPAY',
        address: 'PVR Cinemas, Lumbini Avenue, Gachibowli',
        cancelOder: 'Track Order'),
    Item(
        name: 'Prakash Reddy E',
        deliveryTime: '23-03-2018',
        oderId: '#CN75695',
        oderAmount: '\₹ 250',
        paymentType: 'CARD',
        address: 'PVR Cinemas, Lumbini Avenue, Gachibowli',
        cancelOder: 'View Receipt'),
    Item(
        name: 'John Wick',
        deliveryTime: '10-05-2107',
        oderId: '#CN45238',
        oderAmount: '\₹ 500',
        paymentType: 'GPAY',
        address: 'PVR Cinemas, Lumbini Avenue, Gachibowli',
        cancelOder: 'Track Order'),
    Item(
        name: 'Tom Cruise',
        deliveryTime: '26-10-2016',
        oderId: '#CN69532',
        oderAmount: '\₹ 1120',
        paymentType: 'COD',
        address: 'PVR Cinemas, Lumbini Avenue, Gachibowli',
        cancelOder: 'View Receipt'),
  ];

  // String toolbarname = 'Fruiys & Vegetables';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String toolbarname;

  oder_history(this.toolbarname);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    IconData _backIcon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.arrow_back;
        case TargetPlatform.iOS:
          return Icons.arrow_back_ios;
      }
      assert(false);
      return null;
    }

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    final Orientation orientation = MediaQuery.of(context).orientation;
    return new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(_backIcon()),
            alignment: Alignment.centerLeft,
            tooltip: 'Back',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(toolbarname),
          backgroundColor: Colors.white,
        ),
        body: ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (BuildContext cont, int ind) {
              return SafeArea(
                  child: Column(children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                        color:Colors.black12,
                        child: Card(
                            elevation: 4.0,
                            child: Container(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 10.0, 10.0, 10.0),
                                child: GestureDetector(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        // three line description
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            itemList[ind].name,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontStyle: FontStyle.normal,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),

                                        Container(
                                          margin: EdgeInsets.only(top: 3.0),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Delivery Date :' +
                                                itemList[ind].deliveryTime,
                                            style: TextStyle(
                                                fontSize: 13.0, color: Colors.black54),
                                          ),
                                        ),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.amber.shade500,
                                        ),

                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                                padding: EdgeInsets.all(3.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      'Order Id',
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black54),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(top: 3.0),
                                                      child: Text(
                                                        itemList[ind].oderId,
                                                        style: TextStyle(
                                                            fontSize: 15.0,
                                                            color: Colors.black87),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                            Container(
                                                padding: EdgeInsets.all(3.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      'Order Amount',
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black54),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(top: 3.0),
                                                      child: Text(
                                                        itemList[ind].oderAmount,
                                                        style: TextStyle(
                                                            fontSize: 15.0,
                                                            color: Colors.black87),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            Container(
                                                padding: EdgeInsets.all(3.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      'Payment Type',
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black54),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(top: 3.0),
                                                      child: Text(
                                                        itemList[ind].paymentType,
                                                        style: TextStyle(
                                                            fontSize: 15.0,
                                                            color: Colors.black87),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          ],
                                        ),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.amber.shade500,
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(
                                              Icons.location_on,
                                              size: 20.0,
                                              color: Colors.amber.shade500,
                                            ),
                                            Text(itemList[ind].address,
                                                style: TextStyle(
                                                    fontSize: 13.0,
                                                    color: Colors.black54)),
                                          ],
                                        ),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.amber.shade500,
                                        ),
                                        Container(
                                            child:_status(itemList[ind].cancelOder)
                                        )
                                      ],
                                    ))))),
                  ]));
            }));
  }

  _verticalDivider() => Container(
    padding: EdgeInsets.all(2.0),
  );

  Widget _status(status) {
    if(status == 'Cancel Order'){
      return FlatButton.icon(
          label: Text(status,style: TextStyle(color: Colors.red),),
          icon: const Icon(Icons.highlight_off, size: 18.0,color: Colors.red,),
          onPressed: () {
            // Perform some action
          }
      );
    }
    else{
      return FlatButton.icon(
          label: Text(status,style: TextStyle(color: Colors.green),),
          icon: const Icon(Icons.check_circle, size: 18.0,color: Colors.green,),
          onPressed: () {
            // Perform some action
          }
      );
    }
    if (status == "3") {
      return Text('Process');
    } else if (status == "1") {
      return Text('Order');
    } else {
      return Text("Waiting");
    }
  }
  erticalD() => Container(
    margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
  );

  bool a = true;
  String mText = "Press to hide";
  double _lowerValue = 1.0;
  double _upperValue = 100.0;

  void _visibilitymethod() {
    setState(() {
      if (a) {
        a = false;
        mText = "Press to show";
      } else {
        a = true;
        mText = "Press to hide";
      }
    });
  }
}