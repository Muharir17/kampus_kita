import 'package:flutter/material.dart';

class IntroModel {
  IconData icon;
  String title;
  String description;
  Widget extraWidget;

  IntroModel({this.icon, this.title, this.description, this.extraWidget}) {
    if (extraWidget == null) {
      extraWidget = new Container();
    }
  }
}
