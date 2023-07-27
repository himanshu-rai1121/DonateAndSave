import 'dart:developer';

import 'package:donate_platelets/mongoDB/dbHelper/constants.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter/material.dart';

import '../Models/mongoDbUserInfoModel.dart';

class MongoDatabase {
  static var db, userInfoCollection, userHistoryCollection;

  static connect() async {
    db = await Db.create(Mongo_conn_url);
    await db.open();
    inspect(db);
    userInfoCollection = db.collection(user_info_collection);
    userHistoryCollection = db.collection(user_dynamic_collection);
  }

  static Future<String> insert(MongoDbUserInfoModel data) async {
    try {
      var result = await userInfoCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "data inserted";
      } else {
        return "something went wrong while inserting data";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<void> update(MongoDbUserInfoModel data) async {
    try {
      final result = await userInfoCollection.update(
        where.eq('userId', data.userId),
        modify
            .set('isVerified', data.isVerified)
            .set('isVerified', data.isVerified)
            .set('bloodGroup', data.bloodGroup)
            .set('dob', data.dob)
            .set('address', data.address)
            .set('city', data.city)
            .set('location', data.location)
            .set('phone', data.phone)
            .set('age', data.age)
            .set('healthIssue', data.healthIssue),
      );

      if (result.isSuccess) {
        print('updated successfully.');
      } else {
        print('something went wrong while updating data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userInfoCollection.find().toList();
    return arrData;
  }
}
