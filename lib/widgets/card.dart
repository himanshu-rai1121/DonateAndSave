import 'package:donate_platelets/widgets/submitButtonWithAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dbHelper/mondodb.dart';
import '../models/mongoDbDonerModel.dart';
import '../mongoDB/Models/mongoDbUserInfoModel.dart';
import '../mongoDB/dbHelper/mongodb.dart';
import 'users_card_widget.dart';

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MongoDatabase.getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              var totalData = snapshot.data.length;
              print("total Data" + totalData.toString());
              return GridView.builder(
                  padding: const EdgeInsets.all(20.0),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    childAspectRatio: 3 / 1.3,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 25.0,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return displayCard(
                        MongoDbUserInfoModel.fromJson(snapshot.data[index]),
                        context);
                  }
                  // scrollDirection: Axis.vertical,
                  // shrinkWrap: true,
                  );
            } else {
              return Center(
                child: Text("No data Available"),
              );
            }
          }
        });
  }

  Widget displayCard(MongoDbUserInfoModel data, BuildContext context) {
    // print(data.bloodGroup);
    return GestureDetector(
        child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: Color.fromARGB(127, 140, 135, 3).withOpacity(.5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orangeAccent,
                  Colors.yellow,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: CircleAvatar(
                      backgroundColor: Color.fromARGB(24, 131, 118, 18),
                      radius: 60.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                            child: Image(
                              image: AssetImage('assets/images/heart.png'),
                              color:
                                  Color.fromRGBO(5, 98, 77, 1).withOpacity(0.2),
                              // fit: BoxFit
                              //     .fill, // Set the fit to cover the container
                            ),
                          ),
                        ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.droplet,
                      size: 22.0,
                      color: Color.fromRGBO(251, 99, 66, 1),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      // "A++",
                      data.bloodGroup.toString(),
                      style: TextStyle(
                        color: Color.fromRGBO(5, 98, 77, 1),
                        fontSize: 19,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(10)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.user,
                          size: 22.0,
                          color: Color.fromRGBO(251, 99, 66, 1),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            data.name.toString(),
                            style: TextStyle(
                              color: Color.fromRGBO(5, 98, 77, 1),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.locationArrow,
                          size: 22.0,
                          color: Color.fromRGBO(251, 99, 66, 1),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "Delhi",
                          // data.city.toString(),
                          style: TextStyle(
                            color: Color.fromRGBO(5, 98, 77, 1),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: 35,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: CustomMainButton(
                          onPressed: () {}, buttonName: "Request"))
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
