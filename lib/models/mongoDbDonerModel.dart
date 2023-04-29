/*
{
  "_id":"",
  "name":"My name",
  "bloodGroup":"A+",
  "phone":"+91 6377403312",
  "address":"My address",
  "city":"City"
}
*/
// To parse this JSON data, do
//
//     final mongoDbDonerModel = mongoDbDonerModelFromJson(jsonString);

import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

MongoDbDonerModel mongoDbDonerModelFromJson(String str) =>
    MongoDbDonerModel.fromJson(json.decode(str));

String mongoDbDonerModelToJson(MongoDbDonerModel data) =>
    json.encode(data.toJson());

class MongoDbDonerModel {
  ObjectId id;
  String name;
  String bloodGroup;
  String phone;
  String address;
  String city;

  MongoDbDonerModel({
    required this.id,
    required this.name,
    required this.bloodGroup,
    required this.phone,
    required this.address,
    required this.city,
  });

  factory MongoDbDonerModel.fromJson(Map<String, dynamic> json) =>
      MongoDbDonerModel(
        id: json["_id"],
        name: json["name"],
        bloodGroup: json["bloodGroup"],
        phone: json["phone"],
        address: json["address"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "bloodGroup": bloodGroup,
        "phone": phone,
        "address": address,
        "city": city,
      };
}
