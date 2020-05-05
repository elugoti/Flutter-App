import 'dart:convert';

import 'package:firstflutter/model/Post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class JsonParsingSimple extends StatefulWidget {
  @override
  _JsonParsingSimpleState createState() => _JsonParsingSimpleState();
}

class _JsonParsingSimpleState extends State<JsonParsingSimple> {
  Future<PostList> data;

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
        title: Text("Json Parsing"),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
              future: data,
              builder: (context, AsyncSnapshot<PostList> snapshot) {
                if(snapshot.hasData){
                  return showListViewData(context,snapshot.data.posts);
                }else{
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }

  Future<PostList> getData() {
    String url = "https://jsonplaceholder.typicode.com/posts";
    var data;
    Network network = new Network(url);
    data = network.fetchData();
    //print(data);
    return data;
  }

  Widget showListViewData(BuildContext context, List<Post> snapshot) {
    return Container(
      child: ListView.builder(itemCount :snapshot.length,itemBuilder: (context,int positon){
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: <Widget>[
             Divider(height: 5.0),
             ListTile(
               leading: Column(
                 children: <Widget>[
                   CircleAvatar(
                     backgroundColor: Colors.black45,
                     radius: 23,
                     child: Text("${snapshot[positon].id}"),
                   )
                 ],
               ),
               title: Text("${snapshot[positon].title}"),
               subtitle:Text("${snapshot[positon].body}") ,
             ),
           ],
        );
      }),
    );
  }
}

class Network {
  final String url;

  Network(this.url);

  Future<PostList> fetchData() async {
    //debugPrint("$url");
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      //debugPrint(response.body);
      return PostList.fromJson(json.decode(response.body));
    } else {
      debugPrint("${response.statusCode}");
    }
  }
}
