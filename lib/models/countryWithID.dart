import 'dart:ui';

import 'package:flutter/material.dart';

class countryWithID {
  countryWithID(
      this.name,
      this.code,
      );

  String ? name;
  String ? code;

  countryWithID.fromJson(Map<String,dynamic> json)
  {
    name = json["name"];
    code = json["id"];
  }
}