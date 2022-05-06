import 'package:flutter/material.dart';
import 'package:covid_project/pageone.dart';

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
          textTheme: TextTheme(displayMedium: TextStyle(color: Colors.white))),
      home: wellcomsecreen(),
    );
  }
}

class wellcomsecreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/4.jpg"),
                  fit: BoxFit.cover,
                  //  scale: 12,
                ),
              ),
            )),
        Expanded(
          
            child: Column(
            
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "RIV COVID19",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontWeight: FontWeight.bold))
            ]))
          ],
        ))
      ]),
    );
  }
}
