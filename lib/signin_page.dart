import 'dart:convert';
//import 'dart:js';

import 'main.dart';
import 'package:flutter/material.dart';
import 'pageone.dart';
import 'package:covid_project/signup_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool hiddenpaas =true;

  final TextEditingController usernameController = new TextEditingController();

  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/6.png"),
                  fit: BoxFit.cover, //for fit image on page
                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "SIGN IN",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        FittedBox(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return SignUp();
                                },
                              ));
                            },
                            child: Text(
                              "SIGN UP",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(Icons.email, color: prcolor),
                          ),
                          Expanded(
                              child: TextField(
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    hintText: "Username",
                                  )))
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(Icons.lock, color: prcolor),
                        ),
                        Expanded(
                            child: TextField(
                                  obscureText: hiddenpaas,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  suffixIcon: InkWell(
                                    onTap: _toglepass,
                                    child: Icon(
                                      Icons.visibility,
                                    ),
                                  ),
                                ),
                            ),
                        )
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: <Widget>[
                          FittedBox(
                            child: GestureDetector(
                              //*************************************************************************************** */
                              onTap: () {
                                signin(usernameController.text,
                                    passwordController.text, context);
                                print('hello world');
                              },
                              //************************************************************************************** */
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: prcolor,
                                ),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.2),
                            ),
                            child: Icon(
                              Icons.facebook_outlined,
                              // color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: prcolor,
                            ),
                            child: Icon(
                              Icons.login_sharp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  signin(String username, String password, BuildContext contextt) async {
    print('potato');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map data = {'userName': username, 'userPassword': password};

    var jasonData = null;
    var response = await http.post(
        Uri.parse("http://192.168.1.65:8090/api/v1/authenticate/authenticate"),
        body: json.encode({
          'userName': username,
          'userPassword': password,
        }),
        headers: {"content-type": "application/json"});

    if (response.statusCode == 200) {
      print('acc succcess');
      //var data =jasonData(response.body.toString());
      //print(data);
      jasonData = json.decode(response.body);

      if (jasonData != null) {
        //  setState(() {
        //    _isLoading=false;

        //  });

        prefs.setString("token",jasonData['jwtToken']);
        // prefs.setString("username",jasonData['user']["userName"]);

        Navigator.push(contextt, MaterialPageRoute(
          builder: (context) {
            return wellcomsecreen();//change it to main page not wellcome , wellcome to test only
          },
        ));
      } else {
        //  setState(() {
        //    _isLoading=false;

        //  });
        print(response.body);
      }
    }
    else{
      print(response.statusCode);
    }
  }

  void _toglepass(){

    setState((){
      hiddenpaas=!hiddenpaas;
    });
  }
}
