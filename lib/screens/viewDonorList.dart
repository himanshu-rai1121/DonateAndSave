import 'package:flutter/material.dart';

import '../animation/FadeAnimation.dart';
import '../constants/color_constants.dart';
import '../widgets/card.dart';
import '../widgets/drawerWidget.dart';
import 'donationForm.dart';

class ViewDonorList extends StatefulWidget {
  String bloodGroup;
  ViewDonorList({super.key, required this.bloodGroup});

  @override
  State<ViewDonorList> createState() => _ViewDonorListState();
}

class _ViewDonorListState extends State<ViewDonorList> {
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
            'Donor List',
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
        child: FadeAnimation(
            2.0,
            Cards(
              bloodGroup: widget.bloodGroup,
            )),
      ),
    );
  }
}
