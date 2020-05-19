import 'package:DeliverMyFood/weatherapp/WeatherBroadCast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUser extends StatefulWidget {
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  Future<SharedPreferences> _sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sharedPreferences = SharedPreferences.getInstance();
    _sharedPreferences.then((value)=>{
      debugPrint(""+value.getBool("islogin").toString())
    });
  }

  @override
  Widget build(BuildContext context) {
     return FutureBuilder(future: _sharedPreferences,builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
       if(snapshot.hasData&&snapshot.data.getBool("islogin")!=null&&snapshot.data.getBool("islogin")){
         return WeatherBroadCast();
       }else{
         return Center(child: GestureDetector(onTap : (){
           loginUser();
         },child: Text("Please login first",style: TextStyle(fontSize: 12),)));
       }
     },

     );
  }

  loginUser() {
    debugPrint("hello world");
    _sharedPreferences.then((onValue)=>{
      onValue.setBool("islogin", true)
    });
  }
}
