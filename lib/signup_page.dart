import 'main.dart';
import 'signin_page.dart';
import 'package:flutter/material.dart';
import 'pageone.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}
     bool hiddenpaas=true;
class _SignUpState extends State<SignUp> {
  final TextEditingController usernameeController = new TextEditingController();

  final TextEditingController FirstnameController = new TextEditingController();

  final TextEditingController LastnameController  = new TextEditingController();

  final TextEditingController emailController     = new TextEditingController();

  final TextEditingController passworddController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
      Column(
        children: <Widget>[
          Expanded(
            flex: 2,
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
                          "SIGN UP",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ],
                    ),
                   //  Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(Icons.supervised_user_circle,
                                color: prcolor),
                          ),
                          Expanded(
                              child: TextField(
                                controller: usernameeController,
                                  decoration: InputDecoration(
                            hintText: "USER NAME",
                          )))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(Icons.supervised_user_circle,
                                color: prcolor),
                          ),
                          Expanded(
                              child: TextField(
                                  controller: FirstnameController,
                                  decoration: InputDecoration(
                                    hintText: "First NAME",
                                  )))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(Icons.supervised_user_circle,
                                color: prcolor),
                          ),
                          Expanded(
                              child: TextField(
                                  controller: LastnameController,
                                  decoration: InputDecoration(
                                    hintText: "Last Name",
                                  )))
                        ],
                      ),
                    ),
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
                                controller: emailController,
                                  decoration: InputDecoration(
                            hintText: "Email Address",
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
                                obscureText: true,
                              controller: passworddController,
                                decoration: InputDecoration(
                                   hintText: "Password",
                                  suffixIcon: InkWell(
                                    onTap: _toglepass,
                                    child: Icon(
                                      Icons.visibility,
                                    ),
                                  ),
                        )))
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
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return SignIn();
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
                          FittedBox(
                            child: GestureDetector(
                              //*************************************************************************************** */
                              onTap: () {
                                // signup(context)
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
                                Icons.create,
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

  signup(String username,String firstname,String lastname,String email, String password, BuildContext contextt) async {


    http.Response response =await http.post(
      Uri.parse("uri"),
      body:{
        'username':username,
        'firstname':firstname,
        'lastname':lastname,
        'email':email,
        'password':password,
      }

    );
if(response.statusCode==200)
  {
    print('account is creted ');
  }
else{
  print('Faild');
}



  }


  void _toglepass(){

    setState((){
      hiddenpaas=!hiddenpaas;
    });
  }
}
