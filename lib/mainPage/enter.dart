// ignore_for_file: prefer_const_constructors

import 'package:covid_project/mainPage/chart.dart';
import 'package:covid_project/mainPage/popup.dart';
import 'package:flutter/material.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/services.dart';
import 'cards.dart';

var signIn = true;
List<MenuItem> check = [menuItems.signOut];

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 35, 35, 35)));
  runApp(front());
}

class front extends StatelessWidget {
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
              initialSelection: 'Ps',
              onChanged: (CountryCode) {
                print(CountryCode
                    ?.name); ////////////////////////////// country name
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
}
