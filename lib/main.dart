import 'package:covid_project/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:covid_project/pageone.dart';
import 'package:flutter/src/material/text_theme.dart';
import 'package:covid_project/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'covid project',
      theme: ThemeData(
        primaryColor: prcolor,
        scaffoldBackgroundColor: bgcolor,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          displayMedium: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
          //button: TextStyle(color: prcolor),
          displayLarge: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 36),

          // button: TextStyle(color: Color.fromRGBO(148, 36, 29, 1)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
        ),
      ),
      home: wellcomsecreen(),
    );
  }
}

class wellcomsecreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                 image: AssetImage("images/6.png"),
                  fit: BoxFit.cover,
                  //  scale: 12,
                ),
              ),
            )),
        Expanded(
            child: Column(
          children: [
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: "RIV COVID19\n",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ])),
            FittedBox(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return SignIn();
                    },
                  ));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: prcolor,
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Let's Start",
                        style: Theme.of(context).textTheme.button?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.arrow_forward, color: Colors.white)
                    ],
                  ),
                ),
              ),
            )
          ],
        ))
      ]),
    );
  }
}
