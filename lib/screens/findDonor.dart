import 'dart:ffi';

import 'package:donate_platelets/widgets/card.dart';
import 'package:flutter/material.dart';

import 'package:donate_platelets/constants/color_constants.dart';
import 'package:donate_platelets/screens/donationForm.dart';
import 'package:donate_platelets/widgets/drawerWidget.dart';

class FindDonor extends StatefulWidget {
  const FindDonor({super.key});

  @override
  State<FindDonor> createState() => _FindDonorState();
}

class _FindDonorState extends State<FindDonor> {
  String gender = "";
  String selectedBlood = "";
  String relation = "";
  List<String> bloodGroups = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];
  List<String> relationsList = ["Family", "friends", "Other"];
  int? selectedAge = 21;
  List<int> ages = List.generate(100, (index) => index + 1);

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
            'Find Donor',
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
              Navigator.pushNamed(context, '/donation');
              // Navigator.pushNamed(context, '/signUp');
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Patient Blood Type:",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              height: 100,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: bloodGroups
                      .map(
                        (e) => Row(
                          children: [
                            customButton(selectedBlood, e, () {
                              setState(() {
                                selectedBlood = e;
                              });
                            }),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      )
                      .toList()),
            ),
            const Text(
              "Gender:",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customButton(gender, "Male", () {
                    setState(() {
                      gender = "Male";
                      print(gender);
                    });
                  }),
                  const SizedBox(
                    width: 10,
                  ),
                  customButton(gender, "Female", () {
                    setState(() {
                      gender = "Female";
                      print(gender);
                    });
                  }),
                ],
              ),
            ),
            const Text(
              "Patient Relation:",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              height: 100,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: relationsList
                      .map(
                        (e) => Row(
                          children: [
                            customButton(relation, e, () {
                              setState(() {
                                relation = e;
                              });
                            }),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      )
                      .toList()),
            ),
            const Text(
              "Patient Age:",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(15),
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border: Border.all(width: 5, color: kPrimaryColor)),
                child: DropdownButton<int>(
                  value: selectedAge,
                  onChanged: (value) {
                    setState(() {
                      selectedAge = value;
                    });
                  },
                  items: ages.map((int age) {
                    return DropdownMenuItem<int>(
                      value: age,
                      child: Text(age.toString()),
                    );
                  }).toList(),
                ),
              ),
            ),
            Center(
                child: findButton(gender, selectedBlood, relation,
                    selectedAge.toString(), context)),
          ],
        ),
      ),
    );
  }
}

Widget customButton(String gender, String buttonGender, Function ontap) {
  return GestureDetector(
    onTap: () {
      ontap();
    },
    child: Container(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      decoration: BoxDecoration(
          color: gender == buttonGender ? kPrimaryColor : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(width: 5, color: kPrimaryColor)),
      child: Text(
        buttonGender,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

Widget findButton(
  String gender,
  String bloodGroup,
  String relation,
  String Age,
  BuildContext context,
) {
  return GestureDetector(
    onTap: () {
      print(bloodGroup + " " + gender + " " + relation + " " + Age);
      Navigator.pushNamed(context, '/signUp');
    },
    child: Container(
      margin: EdgeInsets.all(10),
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      width: MediaQuery.of(context).size.width * 5 / 6,
      height: 60,
      decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(width: 5, color: kPrimaryColor)),
      child: const Align(
        alignment: Alignment.center,
        child: Text(
          "Search",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
