// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:covid_project/mainPage/chart.dart';
import 'package:covid_project/mainPage/popup.dart';
import 'package:flutter/material.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/services.dart';
import 'cards.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/country.dart';

var signIn = true;
List<MenuItem> check = [menuItems.signOut];

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 35, 35, 35)));
  runApp(front());
}

class front extends StatefulWidget {
  @override
  State<front> createState() => _frontState();
}

class _frontState extends State<front> {
  String contryCode = "AF";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          leading: CountryListPick(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: Text('Select Country'),
              ),
              theme: CountryTheme(
                isShowFlag: true,
                isShowTitle: false,
                isShowCode: false,
                isDownIcon: false,
                showEnglishName: true,
              ),
              initialSelection: contryCode,
              onChanged: (CountryCode) {
                setState(() {
                  contryCode = CountryCode!.code.toString();
                });
                print(CountryCode?.code); ////////////////////////////// country name
                getinfo(contryCode);
              },
              useUiOverlay: true,
              useSafeArea: false),
          title: Text("COVID_19", style: TextStyle(fontSize: 30)),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 35, 35, 35),
          actions: [
            popup(),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [cards(), Chart()],
          ),
        ));
  }

  getinfo(String contryCode)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token=(prefs.getString('token')??'');
    final response =await http.get(Uri.parse("http://192.168.1.65:8090/api/v1/covid/byDateAndCountry/2022-04-06/"+contryCode),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+token,
        "content-type": "application/json"
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      final list = await json.decode(response.body) as List<dynamic>;
      print(json.decode(response.body));
      return list.map((e) => countryModel.fromJson(e)).toList();
    } else {
      print(response.statusCode);
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
