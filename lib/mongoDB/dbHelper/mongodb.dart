import 'dart:convert';
import 'dart:developer';

import 'package:donate_platelets/mongoDB/dbHelper/constants.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter/material.dart';

import '../Models/mongoDbDynamicDatabaseModel.dart';
import '../Models/mongoDbUserInfoModel.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class MongoDatabase {
  static var db, userInfoCollection, userDynamicCollection;

  static connect() async {
    db = await Db.create(Mongo_conn_url);
    await db.open();
    inspect(db);
    userInfoCollection = db.collection(user_info_collection);
    userDynamicCollection = db.collection(user_dynamic_collection);
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

  static Future<Map<String, dynamic>> getCurrUserData(String currUserId) async {
    final arrData =
        await userInfoCollection.findOne(where.eq("userId", currUserId));
    return arrData;
  }

  // static Future<List<Map<String, dynamic>>> getDonorData(    // it find all donor without any filter
  //     String bloodGroup) async {
  //   final arrData = await userInfoCollection
  //       .find(where.eq("bloodGroup", bloodGroup))
  //       .toList();
  //   return arrData;
  // }

  static Future<List<Map<String, dynamic>>> getCustomDonorData(
      // show this result on search page
      String bloodGroup,
      String? currUserId) async {
    print(currUserId);
    final query = (where
        .eq("requesterId", currUserId)
        .oneFrom("status", ["Active", "Accepted"]));

    final tempData = await userDynamicCollection.find(query).toList();
    // final donorIds = tempData.map((doc) => doc['donorId']).toList();
    // print(tempData);
    // print(donorIds);
    // return tempData;
    final arrData = await userInfoCollection
        .find(where
            .eq("bloodGroup", bloodGroup)
            .nin("userId", [for (var data in tempData) data['donorId']]))
        .toList();
    // print(tempData);
    return arrData;
  }

  static Future<List<Map<String, dynamic>>> allDonorData(
      // show this result on home page, without any filter
      String? currUserId) async {
    final query = (where
        .eq("requesterId", currUserId)
        .oneFrom("status", ["Active", "Accepted"]));

    final tempData = await userDynamicCollection.find(query).toList();
    final arrData = await userInfoCollection
        .find(where
            .eq('isVerified', true)
            .nin("userId", [for (var data in tempData) data['donorId']]))
        .toList();
    return arrData;
  }

  static Future<String> insertIntoDynamic(
      MongoDbDynamicDatabaseModel data) async {
    try {
      var result = await userDynamicCollection.insertOne(data.toJson());
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

  static Future<List<Map<String, dynamic>>> getHistory(
      {String? currUserId, required isDonatedHistory}) async {
    final arrData = isDonatedHistory
        ? await userDynamicCollection
            .find(where.eq("donorId", currUserId).eq("status", "completed"))
            .toList()
        : await userDynamicCollection
            .find(where.eq("requesterId", currUserId).eq("status", "completed"))
            .toList();

    return arrData;
  }

  static Future<List<Map<String, dynamic>>> getRequests(
      {String? currUserId,
      required bool isSendRequest,
      required String status}) async {
    print(currUserId.toString() + " " + isSendRequest.toString() + status);
    final arrData;
    if (isSendRequest) {
      if (status == "Active") {
        arrData = await userDynamicCollection
            .find(where.eq("requesterId", currUserId).eq("status", "Active"))
            .toList();
      } else if (status == "Accepted") {
        arrData = await userDynamicCollection
            .find(where.eq("requesterId", currUserId).eq("status", "Accepted"))
            .toList();
      } else {
        arrData = await userDynamicCollection
            .find(where.eq("requesterId", currUserId).eq("status", "Rejected"))
            .toList();
      }
    } else {
      if (status == "Active") {
        arrData = await userDynamicCollection
            .find(where.eq("donorId", currUserId).eq("status", "Active"))
            .toList();
      } else if (status == "Accepted") {
        arrData = await userDynamicCollection
            .find(where.eq("donorId", currUserId).eq("status", "Accepted"))
            .toList();
      } else {
        arrData = await userDynamicCollection
            .find(where.eq("donorId", currUserId).eq("status", "Rejected"))
            .toList();
      }
    }

    return arrData;
  }

  static Future<void> updateRequestStatus(M.ObjectId id, String status) async {
    try {
      print(id.toString() + " " + status);
      final result = await userDynamicCollection.update(
        where.eq('_id', id),
        modify.set('status', status),
      );
      print(result);

      if (result['ok'] == 1) {
        // Check the 'ok' field to determine success
        print('updated successfully.');
      } else {
        print('something went wrong while updating data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
