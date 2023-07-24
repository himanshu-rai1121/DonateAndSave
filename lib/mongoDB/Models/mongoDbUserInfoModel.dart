/*
  {
    "_id":"",               // primary key in mongo database
    "userId":"hjjhh"       // taken from firebase while login (or unique key of firebase)
    "name":"My name",
    "email":"himanshukumarrai786@gmail.com ",
    "isVerified": false,
    
    "bloodGroup":"A+",
    "dob":"15/04/2002",
    
    "address":"My address",
    "city":"City",
    "location":"102.33.25.2",
    
    "phone":"+91 6377403312",
    
    "age":20,
    "Health issue":"NA"
  }
*/

// To parse this JSON data, do
//
//     final mongoDbUserInfoModel = mongoDbUserInfoModelFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbUserInfoModel mongoDbUserInfoModelFromJson(String str) =>
    MongoDbUserInfoModel.fromJson(json.decode(str));

String mongoDbUserInfoModelToJson(MongoDbUserInfoModel data) =>
    json.encode(data.toJson());

class MongoDbUserInfoModel {
  ObjectId id; // primary key in mongo database
  String userId; // taken from firebase while login (or unique key of firebase)
  String name;
  String email;
  bool isVerified;
  String bloodGroup;
  String dob;
  String address;
  String city;
  String location;
  String phone;
  int age;
  String healthIssue;

  MongoDbUserInfoModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.isVerified,
    required this.bloodGroup,
    required this.dob,
    required this.address,
    required this.city,
    required this.location,
    required this.phone,
    required this.age,
    required this.healthIssue,
  });

  factory MongoDbUserInfoModel.fromJson(Map<String, dynamic> json) =>
      MongoDbUserInfoModel(
        id: json["_id"],
        userId: json["userId"],
        name: json["name"],
        email: json["email"],
        isVerified: json["isVerified"],
        bloodGroup: json["bloodGroup"],
        dob: json["dob"],
        address: json["address"],
        city: json["city"],
        location: json["location"],
        phone: json["phone"],
        age: json["age"],
        healthIssue: json["healthIssue"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "name": name,
        "email": email,
        "isVerified": isVerified,
        "bloodGroup": bloodGroup,
        "dob": dob,
        "address": address,
        "city": city,
        "location": location,
        "phone": phone,
        "age": age,
        "healthIssue": healthIssue,
      };
}
