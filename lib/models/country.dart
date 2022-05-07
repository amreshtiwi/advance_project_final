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
    date = json["dateReported"];
    country = json["country"]["name"];
    code = json["country"]["postalCode"];
    cumCases = json["cumulativeCases"];
    cumDeaths = json["cumulativeDeaths"];
    newCases = json["newCases"];
    newDeaths = json["newDeaths"];
  }
}