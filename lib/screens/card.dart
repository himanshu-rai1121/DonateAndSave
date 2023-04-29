import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dbHelper/mondodb.dart';
import '../models/mongoDbDonerModel.dart';
import '../widgets/users_card_widget.dart';

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
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 25.0,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return displayCar(
                        MongoDbDonerModel.fromJson(snapshot.data[index])
                        // userDP: users[0].userDP,
                        // userId: users[index].userId,
                        // userLocation: users[index].userLocation,
                        // userName: users[index].userName,
                        // userPhone: users[index].userPhone,
                        // userBlood: users[index].userBlood,
                        // userCity: users[index].userCity,
                        );
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

  // Future<void> _showMyDialog(BuildContext context) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(15),
  //           ),
  //         ),
  //         title: Center(
  //           child: Text(
  //             'Heroic story of ${data.name.split(' ')[0]}',
  //             style: TextStyle(
  //               fontFamily: 'Poppins',
  //             ),
  //           ),
  //         ),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text(
  //                 'I have discussed with the doctor and followed some basics rules like drinking light warm water, drinking green tea with lemon, having steam and taking proper rest.',
  //                 style: TextStyle(
  //                   fontFamily: 'Poppins',
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           ElevatedButton(
  //             child: Text(
  //               'Thanks',
  //               style: TextStyle(
  //                 fontFamily: 'Poppins',
  //                 color: Colors.pinkAccent.shade400,
  //               ),
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  Widget displayCar(MongoDbDonerModel data) {
    return GestureDetector(
      // onLongPress
      onTap: () {
        // _showMyDialog(context);
      },
      child: Container(
        // height: 200.0,
        // width: 7000.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(-4, 4),
              blurRadius: 10,
              color: Color(0xFF212121).withOpacity(.2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image.asset('assets/images/rahul.png'
                        // widget.userDP
                        ), // change for profile picture of user (DP)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Icon(
                    Icons.textsms,
                    size: 26.0,
                    color: Colors.deepOrange.shade400,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 0, 8),
              child: Row(
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.userAstronaut,
                    size: 16.0,
                    color: Colors.orangeAccent,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    data.name,
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 8),
              child: Row(
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.searchLocation,
                    size: 16.0,
                    color: Colors.deepOrangeAccent,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    data.address,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 8),
              child: Row(
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.locationArrow,
                    size: 16.0,
                    color: Colors.deepOrangeAccent,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    data.city,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 2),
              child: Row(
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.heart,
                    size: 16.0,
                    color: Colors.deepOrange,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    data.bloodGroup,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 35.0,
                  width: 35.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    color: Colors.green,
                  ),
                  child: new IconButton(
                    iconSize: 19.0,
                    icon: new Icon(
                      Icons.dialer_sip,
                      color: Colors.white,
                    ),
                    // onPressed: () {},
                    onPressed: () {
                      // launch('tel:+919955640114');
                      launch('tel:' + data.phone);
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
  // Widget displayCard(MongoDbDonerModel data) {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(15.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text("${data.id.$oid}"),
  //           const SizedBox(
  //             height: 5,
  //           ),
  //           Text("${data.name}"),
  //           const SizedBox(
  //             height: 5,
  //           ),
  //           Text("${data.phone}"),
  //           const SizedBox(
  //             height: 5,
  //           ),
  //           Text("${data.address}"),
  //         ],
  //       ),
  //     ),
  //   );
  // }