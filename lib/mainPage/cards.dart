import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cards extends StatefulWidget {
  var newCases;
  var newDeaths;
  var cumlativeCases;
  var cumlativeDeaths;
  cards ({ Key? key,required this.newCases ,
    required this.newDeaths,
    required this.cumlativeCases,
    required this.cumlativeDeaths }): super(key: key);

  @override
  State<cards> createState() => _cardsState();
}

class _cardsState extends State<cards> {

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: 350, minHeight: 200, maxWidth: 600, minWidth: 200),
      child: Container(
          margin: EdgeInsets.only(left: 5, right: 5, top: 40),
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 239, 161, 58),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                  offset: Offset(1, 4), // Shadow position
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(widget.newCases.toString(),
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      ((widget.newCases/widget.cumlativeCases)*100).toStringAsFixed(2)+"%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text("Cases",
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Icon(Icons.medical_services_rounded,
                                      size: 40,
                                      color: Color.fromARGB(255, 204, 137, 47)),
                                ),
                              )
                            ],
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 239, 161, 58),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                  offset: Offset(1, 4), // Shadow position
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(widget.newDeaths.toString(),
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                    Text(((widget.newDeaths/widget.cumlativeDeaths)*100).toStringAsFixed(2)+"%",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    Text("Deaths",
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Icon(Icons.heart_broken,
                                      size: 40,
                                      color: Color.fromARGB(255, 204, 137, 47)),
                                ),
                              )
                            ],
                          )),
                    ),
                  ]),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 239, 161, 58),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4,
                                    offset: Offset(1, 4), // Shadow position
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(widget.cumlativeCases.toString(),
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                      Text("Cumulative cases",
                                          style: TextStyle(fontSize: 18)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Icon(Icons.monitor_heart_rounded,
                                        size: 40,
                                        color:
                                            Color.fromARGB(255, 204, 137, 47)),
                                  ),
                                )
                              ],
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 239, 161, 58),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4,
                                    offset: Offset(1, 4), // Shadow position
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(widget.cumlativeDeaths.toString(),
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text("Cumulative deaths",
                                          style: TextStyle(fontSize: 18)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Icon(Icons.flag,
                                        size: 40,
                                        color:
                                            Color.fromARGB(255, 204, 137, 47)),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
