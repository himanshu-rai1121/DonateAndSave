import 'package:donate_platelets/mongoDB/Models/mongoDbDynamicDatabaseModel.dart';
import 'package:donate_platelets/mongoDB/dbHelper/mongodb.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:donate_platelets/animation/FadeAnimation.dart';
import 'package:donate_platelets/constants/color_constants.dart';
import 'package:donate_platelets/screens/donationForm.dart';
import 'package:donate_platelets/widgets/drawerWidget.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../sharedPreference/auth_service.dart';
import '../widgets/snackbar.dart';
import '../widgets/submitButtonWithAnimation.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String selectedButton = "Donated";
  String? currUserId = "";

  @override
  void initState() {
    super.initState();
    // Get the user ID when the app starts
    getUserId();
  }

  void getUserId() async {
    String? currUserId = await AuthService.getUserIdFromSharedPrefs();
    setState(() {
      this.currUserId = currUserId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Donation History',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.short_text,
            size: 40,
            color: kAccentColor,
          ),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(DonationForm.routeName);
            },
            icon: Icon(
              Icons.pan_tool,
              size: 25,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: donatedOrReceivedButton(
                    buttonName: 'Donated',
                    selectedButton: selectedButton,
                    ontap: () {
                      setState(() {
                        {
                          setState(() {
                            selectedButton = "Donated";
                            print("Donated");
                          });
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: donatedOrReceivedButton(
                        selectedButton: selectedButton,
                        ontap: () {
                          {
                            setState(() {
                              selectedButton = "Received";
                              print("RECEIVED");
                            });
                          }
                        },
                        buttonName: 'Received'))
              ],
            ),
            Container(
              child: selectedButton == "Donated"
                  ? getHistory(
                      "Donated",
                      context,
                      currUserId,
                    )
                  : getHistory("Received", context, currUserId),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getHistory(
    String donateOrReceived, BuildContext context, String? currUserId) {
  return FutureBuilder(
      future: donateOrReceived == "Donated"
          ? MongoDatabase.getHistory(
              currUserId: currUserId, isDonatedHistory: true)
          : MongoDatabase.getHistory(
              currUserId: currUserId, isDonatedHistory: false),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            var totalData = snapshot.data.length;
            print("total Data" + totalData.toString());
            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return getHistoryCard(
                        MongoDbDynamicDatabaseModel.fromJson(
                            snapshot.data[index]),
                        context,
                        donateOrReceived);
                  }),
            );
          } else if (snapshot.hasError) {
            // Handle the case when there's an error fetching data
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            // Handle the case when there's no data
            return Center(
              child: Text("No data available"),
            );
          }
        }
      });
}

Widget donatedOrReceivedButton(
    {required String selectedButton,
    required String buttonName,
    required Function ontap}) {
  return GestureDetector(
    onTap: () {
      print("1");
      ontap();
    },
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 237, 215, 16), width: 5),
        borderRadius: BorderRadius.circular(30),
        gradient: selectedButton == buttonName
            ? LinearGradient(
                colors: [
                  Colors.orangeAccent,
                  Colors.yellow,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white12,
                ],
              ),
      ),
      child: Center(
        child: Text(
          buttonName,
          style: TextStyle(
            color: selectedButton != buttonName ? Colors.yellow : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    ),
  );
}

Widget getHistoryCard(MongoDbDynamicDatabaseModel data, BuildContext context,
    String donateOrReceived) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(-4, 4),
            blurRadius: 10,
            color: Color(0xFF212121).withOpacity(.2),
          ),
        ],
        // color: Colors.amber.shade400,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            addData("Date : ", data.date),
            addData(
                donateOrReceived == "Donated"
                    ? "Receiver Id : "
                    : "Donor Id : ",
                donateOrReceived == "Donated"
                    ? data.requesterId.substring(data.requesterId.length - 4)
                    : data.donorId.substring(data.requesterId.length - 4)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            addData("location : ", data.location),
            addData("Qty : ", data.quantity.toString()),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              child: const Text(
                "View Detail > ",
                style: TextStyle(
                  color: kPrimaryColor,
                  decoration: TextDecoration.underline,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                customSnackBar(context, "Currently not functional");
              },
            ),
          ],
        )
      ],
    ),
  );
}

Widget addData(String title, String desc) {
  return Row(
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
      Text(
        desc,
        style: const TextStyle(
          fontSize: 10,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
