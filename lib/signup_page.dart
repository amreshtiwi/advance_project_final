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
var erruname,errfname,errlname,erremail,errpass;
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
              flex: 5,
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
                                    errorText: erruname,
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
                                    errorText: errfname,
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
                                    errorText: errlname,
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
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                            hintText: "Email Address",
                                    errorText: erremail,

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
                                  errorText: errpass,
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
                                setState(() {
                                  erruname=null;
                                  errfname=null;
                                  errlname=null;
                                  erremail=null;
                                  errpass=null;
                                });
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

                                if(usernameeController.text.isEmpty)
                                  {
                                    setState(() {
                                      erruname="Not valid Username";
                                    });

                                  }
                                else
                                  {
                                  setState(() {
                                  erruname=null;
                                  });
                                  }
                                 if(FirstnameController.text.isEmpty)
                                  {
                                    setState(() {
                                      errfname="Not valid Firstname";
                                    });

                                  }
                                 else
                                 {
                                   setState(() {
                                     errfname=null;
                                   });
                                 }
                                 if(LastnameController.text.isEmpty)
                                  {
                                    setState(() {
                                      errlname="Not valid Lastname";

                                    });

                                  }
                                 else
                                 {
                                   setState(() {
                                     errlname=null;
                                   });
                                 }
                                 if(emailController.text.isEmpty)
                                  {
                                    setState(() {
                                      erremail="Not valid Email";
                                    });

                                  }
                                 else
                                 {
                                   setState(() {
                                     erremail=null;
                                   });
                                 }
                                 if(passworddController.text.isEmpty)
                                  {
                                    setState(() {
                                      errpass="Not valid Password";
                                    });

                                  }

                                else
                                  {
                                  setState(() {
                                    errpass=null;
                                  });
                                  }
                                // signup(context)
                                print("hi im hosny");
                                  signup( usernameeController.text,
                                      FirstnameController.text,
                                      LastnameController.text,
                                      emailController.text,
                                      passworddController.text,
                                      context);

                                // Navigator.push(context, MaterialPageRoute(
                                //   builder: (context) {
                                //     return wellcomsecreen();
                                //   },
                                // )
                                // );
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

    print("hi im omar");
    var response =await http.post(Uri.parse("http://192.168.1.65:8090/api/v1/user/addUser"),body:json.encode({
    'userName':username,
    'firstName':firstname,
    'lastName':lastname,
    'email':email,
    'password':password,
      'role' : "User"

    }), headers: {"content-type": "application/json"});

    if(response.statusCode==200)
  {
    print('account is creted ');

    usernameeController.text="";
    FirstnameController.text="";
    LastnameController.text="";
    emailController.text="";
    passworddController.text="";

    final snakbar =SnackBar(content: Text("Account is Created"));
    ScaffoldMessenger.of(context).showSnackBar(snakbar);

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
