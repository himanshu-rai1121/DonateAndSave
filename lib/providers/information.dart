import 'package:donate_platelets/models/info.dart';
import 'package:donate_platelets/themes/themes_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Information extends ChangeNotifier {
  List<Info> _information = [
    Info(
        color: Colors.greenAccent.shade400,
        infoId: 1,
        message: 'Be knowledgeable about dengue fever.'),
    Info(
        color: Colors.deepOrangeAccent.shade400,
        infoId: 2,
        message: 'Wear Protective Clothing.'),
    Info(
        color: Colors.pinkAccent,
        infoId: 3,
        message: 'Use mosquito deterrents'),
    Info(
        color: Colors.orangeAccent,
        infoId: 4,
        message: 'Refrain from breeding grounds.'),
    Info(
        color: Colors.greenAccent.shade700,
        infoId: 5,
        message: 'Avoid smells that attract mosquitoes.'),
    Info(
        color: Colors.deepOrangeAccent.shade400,
        infoId: 6,
        message: 'Make sure your home is well-lit.'),
    Info(
        color: Colors.pinkAccent,
        infoId: 7,
        message: 'Use Mosquito Repellent.'),
  ];

  List<Info> get infoList {
    final baseInfoList = [..._information];
    return baseInfoList;
  }
}
