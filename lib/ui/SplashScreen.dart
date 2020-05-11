import 'package:firstflutter/json_parsing/RestaurantList.dart';
import 'package:firstflutter/ui/LoginScreen.dart';
import 'package:firstflutter/weatherapp/WeatherBroadCast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<SplashScreen> {
  Future<SharedPreferences> _sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sharedPreferences = SharedPreferences.getInstance();
    _sharedPreferences.then((value)=>{
      debugPrint("Value: "+value.getBool("islogin").toString())
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _sharedPreferences,builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
      if(snapshot.hasData&&snapshot.data.getBool("islogin")!=null&&snapshot.data.getBool("islogin")){
        return RestaurantListScreen();
      }else{
        return  LoginScreen();
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