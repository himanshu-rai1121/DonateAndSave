/*
  {
      "_id":"",
      "requesterId":"65415dfjn",
      "donorId":"jn44jkn",
      "quantity":2.5,
      "location":"12.3650.256",
      "date":"12/04/2009",
      "status":"Active or pending/accepted/rejected/completed"
  }
*/

// To parse this JSON data, do
//
//     final mongoDbDynamicDatabaseModel = mongoDbDynamicDatabaseModelFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbDynamicDatabaseModel mongoDbDynamicDatabaseModelFromJson(String str) =>
    MongoDbDynamicDatabaseModel.fromJson(json.decode(str));

String mongoDbDynamicDatabaseModelToJson(MongoDbDynamicDatabaseModel data) =>
    json.encode(data.toJson());

class MongoDbDynamicDatabaseModel {
  ObjectId id;
  String requesterId;
  String donorId;
  double quantity;
  String location;
  String date;
  String status;

  MongoDbDynamicDatabaseModel({
    required this.id,
    required this.requesterId,
    required this.donorId,
    required this.quantity,
    required this.location,
    required this.date,
    required this.status,
  });

  factory MongoDbDynamicDatabaseModel.fromJson(Map<String, dynamic> json) =>
      MongoDbDynamicDatabaseModel(
        id: json["_id"],
        requesterId: json["requesterId"],
        donorId: json["donorId"],
        quantity: json["quantity"]?.toDouble(),
        location: json["location"],
        date: json["date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "requesterId": requesterId,
        "donorId": donorId,
        "quantity": quantity,
        "location": location,
        "date": date,
        "status": status,
      };
}
