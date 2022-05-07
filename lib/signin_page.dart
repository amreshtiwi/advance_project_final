import 'dart:convert';
//import 'dart:js';

import 'admin.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'mainPage/enter.dart';
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
  var errorpass;
  var errorname;

  var _formkey = GlobalKey<FormState>();
  final TextEditingController usernameController = new TextEditingController();

  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
              flex: 5,
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
                   // Spacer(),
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
                                    errorText: errorname,

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
                                  errorText:errorpass,
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

                                final snakbar =SnackBar(content: Text("go to wellcom page"));
                                ScaffoldMessenger.of(context).showSnackBar(snakbar);

                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return wellcomsecreen();
                                  },
                                ));
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
                          //Icons.login_sharp,


                          FittedBox(
                            child: GestureDetector(
                              //*************************************************************************************** */
                              onTap: () {
                                signin(usernameController.text,
                                    passwordController.text, context);
                                if(usernameController.text.isEmpty)
                                  {
                                    setState(() {
                                      errorname='Not valid username';
                                    });
                                  }
                                else
                                {
                                  setState(() {
                                    errorname=null;
                                  });
                                }
                                if(passwordController.text.isEmpty)
                                  {
                                    setState(() {
                                      errorpass='Not valid password';
                                    });
                                  }
                                else
                                  {
                                    setState(() {
                                      errorpass=null;
                                    });
                                  }


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
                                  Icons.login_sharp,
                                  color: Colors.white,
                                ),
                              ),
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
        //prefs.setString("role",jasonData['user']["role"]["roleName"]);
        print(jasonData['user']["role"]["roleName"]);
        if(jasonData['user']["role"]["roleName"] == 'User') {
          Navigator.push(contextt, MaterialPageRoute(
            builder: (context) {
              return front(); //change it to main page not wellcome , wellcome to test only
            },
          ));
        }if(jasonData['user']["role"]["roleName"] == 'Admin') {
          Navigator.push(contextt, MaterialPageRoute(
            builder: (context) {
              return admin(); //change it to main page not wellcome , wellcome to test only
            },
          ));
        }
      } else {
        //  setState(() {
        //    _isLoading=false;

        //  });
        print(response.body);
      }
    }
    else{
      print(response.statusCode);

      final snakbar =SnackBar(content: Text("Username or password is Wrong"));
      ScaffoldMessenger.of(context).showSnackBar(snakbar);

    }
  }

  void _toglepass(){

    setState((){
      hiddenpaas=!hiddenpaas;
    });
  }
}
