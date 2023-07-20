import 'package:flutter/material.dart';
import 'package:donate_platelets/animation/FadeAnimation.dart';
import 'package:donate_platelets/constants/color_constants.dart';
import 'package:donate_platelets/screens/donationForm.dart';
import 'package:donate_platelets/widgets/drawerWidget.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/submitButtonWithAnimation.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String selectedButton = "Donated";

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
                  ? getHistory("Donated", context)
                  : getHistory("Received", context),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getHistory(String donateOrReceived, BuildContext context) {
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
            const Text(
              "Date: ",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              donateOrReceived == "Donated" ? "Donor Id: " : "Receiver Id: ",
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "location: ",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Qty : ",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
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
                Navigator.pushNamed(context, '/signUp');
              },
            ),
          ],
        )
      ],
    ),
  );
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
