// import 'dart:developer';

// import 'package:donate_platelets/dbHelper/constants.dart';
// import 'package:donate_platelets/models/mongoDbDonerModel.dart';
// import 'package:mongo_dart/mongo_dart.dart';

// class MongoDatabase {
//   static var db, userCollection;
//   static connect() async {
//     db = await Db.create(MONGO_URL_Conn);
//     await db.open();
//     inspect(db);
//     userCollection = db.collection(USER_COLLECTION);
//   }

//   static Future<String> insert(MongoDbDonerModel data) async {
//     try {
//       var result = await userCollection.insertOne(data.toJson());
//       if (result.isSuccess) {
//         return "Data Inserted";
//       } else {
//         return "Something Wrong while inserting data";
//       }
//     } catch (e) {
//       print(e.toString());
//       return e.toString();
//     }
//   }

//   static Future<List<Map<String, dynamic>>> getData() async {
//     final arrData = await userCollection.find().toList();
//     return arrData;
//   }
// }
