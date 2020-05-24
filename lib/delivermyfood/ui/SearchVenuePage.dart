import 'package:DeliverMyFood/delivermyfood/models/City.dart';
import 'package:DeliverMyFood/delivermyfood/models/Venue.dart';
import 'package:DeliverMyFood/themes/light_color.dart';
import 'package:DeliverMyFood/weatherapp/Utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SearchVenuePage extends StatefulWidget {
  final City city;

  const SearchVenuePage({Key key, this.city}) : super(key: key);
  @override
  _SearchVenuePageState createState() => new _SearchVenuePageState(city);
}

class _SearchVenuePageState extends State<SearchVenuePage> {
  final City city;
  TextEditingController editingController = TextEditingController();

  final duplicateItems = venueList;
  var items = List<String>();

  _SearchVenuePageState(this.city);

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        var temp = item;
        var tempQ = query;
        if(temp.toLowerCase().contains(tempQ.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xffCB202D),
        title: new Text(widget.city.title,style: TextStyle(color: LightColor.white),),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: ()=>  goBack(context,items[index]),
                    title: Text('${items[index]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  goBack(BuildContext context, String item) {
    setState(() {
      Utils.city = city;
      Utils.selectedVenue = item+","+city.title;
    });
    Navigator.pop(context);
  }
}