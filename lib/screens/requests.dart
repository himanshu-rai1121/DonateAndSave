import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../widgets/drawerWidget.dart';
import 'donationForm.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  String selectedIconName = "Active";
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
        // margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-4, 4),
                      blurRadius: 10,
                      color: Color(0xFF212121).withOpacity(.2),
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  activeAcceptedRejected(
                      selectedIconName: selectedIconName,
                      iconName: "Active",
                      ontap: () {
                        setState(() {
                          selectedIconName = "Active";
                        });
                      }),
                  activeAcceptedRejected(
                      selectedIconName: selectedIconName,
                      iconName: "Accepted",
                      ontap: () {
                        setState(() {
                          selectedIconName = "Accepted";
                        });
                      }),
                  activeAcceptedRejected(
                      selectedIconName: selectedIconName,
                      iconName: "Rejected",
                      ontap: () {
                        setState(() {
                          selectedIconName = "Rejected";
                        });
                      })
                ],
              ),
            ),
            getRequest("Active", context)
          ],
        ),
      ),
    );
  }
}

Widget activeAcceptedRejected(
    {required String selectedIconName,
    required String iconName,
    required Function ontap}) {
  return GestureDetector(
    child: Container(
      // height: 50,
      child: Text(
        iconName,
        style: TextStyle(
          color: selectedIconName == iconName ? kPrimaryColor : null,
          decoration:
              selectedIconName == iconName ? TextDecoration.underline : null,
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    onTap: () {
      ontap();
    },
  );
}

Widget getRequest(String status, BuildContext context) {
  return Container(
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      // height: 200,
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
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Requester #1234",
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
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
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            acceptDeclineButton(buttonName: "Accept", ontap: () {}),
            acceptDeclineButton(buttonName: "Decline", ontap: () {}),
          ],
        )
      ]));
}

Widget acceptDeclineButton(
    {required String buttonName, required Function ontap}) {
  return GestureDetector(
    onTap: () {
      ontap();
    },
    child: Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black54),
        borderRadius: BorderRadius.circular(15),
        gradient: buttonName == "Accept"
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
      child: Text(
        buttonName,
        style: TextStyle(
          color: buttonName == "Accept" ? Colors.white : null,
          fontSize: 15,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
