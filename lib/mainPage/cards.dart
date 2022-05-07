import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cards extends StatefulWidget {
  @override
  State<cards> createState() => _cardsState();
}

class _cardsState extends State<cards> {
  var confirmed_num; ///////////////////////////////////////////
  var recoveries_num;
  var decreased_num;
  var country_num;

  var confirmed_percent; //////////////////////////////////////////////
  var recoveries_percent;
  var decreased_percent;
  var country_percent;

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
                                    Text("$confirmed_num",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      "(+$confirmed_percent%)",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text("Confirmed",
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
                                    Text("$recoveries_num",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold)),
                                    Text("(+$recoveries_percent%)",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    Text("Recoveries",
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
                                      Text("$decreased_num",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold)),
                                      Text("(+$decreased_percent%)",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                      Text("Death",
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
                                      Text(
                                        "$country_num/168",
                                        style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "(+$country_percent%)",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("Countries",
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
