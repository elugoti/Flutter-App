import 'package:DeliverMyFood/json_parsing/RestaurantList.dart';
import 'package:DeliverMyFood/ui/PaymentScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<SharedPreferences> _sharedPreferences;
  String userName = "";
  String password = "";
  String userNameError = null;
  String passwordError = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sharedPreferences = SharedPreferences.getInstance();
    _sharedPreferences.then(
        (value) => {debugPrint("" + value.getBool("islogin").toString())});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('DeliverMyFood'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (text) => {changeUserName(text)},
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                        errorText: userNameError),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    onChanged: (text) => {changePassword(text)},
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        errorText: passwordError),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  textColor: Colors.blue,
                  child: Text('Forgot Password'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Login'),
                      onPressed: () {
                        resetErrors();
                        print(userName);
                        print(password);
                        if (isValidData()) {
                          _sharedPreferences.then((onValue) => {
                                onValue.setBool("islogin", true),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PaymentScreen()))
                              });
                        }
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //signup screen
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }

  changeUserName(String text) {
    setState(() {
      userName = text;
    });
  }

  changePassword(String text) {
    setState(() {
      password = text;
    });
  }

  void resetErrors() {
    setState(() {
      userNameError = null;
      passwordError = null;
    });
  }

  bool isValidData() {
    if (userName.isNotEmpty && password.isNotEmpty) {
      return true;
    }
    if (userName.isEmpty) {
      setState(() {
        userNameError = "Enter valid user name";
      });
    }
    if (password.isEmpty) {
      setState(() {
        passwordError = "Enter valid password";
      });
    }
    return false;
  }
}
