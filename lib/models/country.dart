import 'dart:ui';

import 'package:flutter/material.dart';

class countryModel {
  countryModel(
      this.date,
      this.country,
      this.code,
      this.cumCases,
      this.cumDeaths,
      this.newCases,
      this.newDeaths,
      this.color );

  String ? date;
  String ? country;
  String ? code;
  int ? cumCases;
  int ? cumDeaths;
  int ? newCases;
  int ? newDeaths;
  Color ? color;

  countryModel.fromJson(Map<String,dynamic> json)
  {
    date = json["Date_reported"];
    country = json["Country"];
    code = json["Country_code"];
    cumCases = json["Cumulative_cases"];
    cumDeaths = json["Cumulative_deaths"];
    newCases = json["New_cases"];
    newDeaths = json["New_deaths"];
  }
}