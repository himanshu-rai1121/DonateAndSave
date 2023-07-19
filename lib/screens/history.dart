import 'package:flutter/material.dart';
import 'package:donate_platelets/animation/FadeAnimation.dart';
import 'package:donate_platelets/constants/color_constants.dart';
import 'package:donate_platelets/screens/donationForm.dart';
import 'package:donate_platelets/widgets/drawerWidget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Center(
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
            icon: Icon(
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
        body: ListView(
          children: [
            getHistory(),
          ],
        ));
  }
}

Widget getHistory() {
  return Container(
    margin: EdgeInsets.all(10),
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
        Text("Patient Name : "),
        Text("Unit : "),
        Text("Location : "),
      ],
    ),
  );
}
