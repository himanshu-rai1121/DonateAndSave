import 'dart:convert';

import 'package:donate_platelets/constants/color_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mongoDB/Models/mongoDbUserInfoModel.dart';
import '../mongoDB/dbHelper/mongodb.dart';
import '../sharedPreference/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<ProfilePage> {
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
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2.4,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(40))),
                    ),
                    Column(
                      children: [
                        UserContent(currUserId!, context),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ButtonCard("Register", Icons.app_registration, () {
                          Navigator.pushNamed(context, '/register');
                        }),
                        ButtonCard("Share your Story", Icons.share, () {
                          Navigator.pushNamed(context, '/story');
                        }),
                        ButtonCard("History", Icons.history, () {
                          Navigator.pushNamed(context, '/history');
                        }),
                        ButtonCard("Send Requests", Icons.person_add_alt_1, () {
                          Navigator.pushNamed(context, '/sendRequests');
                        }),
                        ButtonCard("Incomming Requests", Icons.person_add, () {
                          Navigator.pushNamed(context, '/requests');
                        }),
                        ButtonCard("Logout", Icons.logout, () {
                          _signOut(context);
                        }),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((value) async {
      // Clear the userId from shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('userId');
      print("logOut succesfully");

      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    });
  }
}

Widget ButtonCard(String text, IconData icon, Function()? ontap) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      height: 60,
      margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: Color.fromARGB(125, 7, 2, 2).withOpacity(.5),
          )
        ],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: TextStyle(
                color: Color.fromRGBO(5, 98, 77, 1),
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              )),
          Icon(
            icon,
            color: Color.fromRGBO(5, 98, 77, 1),
          ),
        ],
      ),
    ),
  );
}

Widget UserContent(String currUserId, BuildContext context) {
  return FutureBuilder<Map<String, dynamic>>(
      future: MongoDatabase.getCurrUserData(
          currUserId), //  fetches data asynchronously
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child:
                  CircularProgressIndicator()); // Show a loading indicator while data is being fetched
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('No data available.');
        } else {
          // final data = snapshot.data!;
          final data = MongoDbUserInfoModel.fromJson(snapshot.data!);
          bool isVerified = data.isVerified;

          return Container(
            margin: EdgeInsets.fromLTRB(20, 90, 20, 0),
            // height: 120,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome > ",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            )),
                        Text(" Glad you're here,",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            )),
                        Text(data.name,
                            style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                    CircleAvatar(
                        backgroundColor: Color.fromARGB(24, 131, 118, 18),
                        // Color.fromARGB(252, 243, 221, 55),
                        radius: 60.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 30, 20, 20),
                              child: Image(
                                image: AssetImage('assets/images/heart.png'),
                                color: Color.fromRGBO(5, 98, 77, 1)
                                    .withOpacity(0.2),
                                // fit: BoxFit
                                //     .fill, // Set the fit to cover the container
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 230,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(4, 4),
                              blurRadius: 10,
                              color: Color.fromARGB(126, 10, 10, 10)
                                  .withOpacity(.5),
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Your Blood Group",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              )),
                          FaIcon(
                            FontAwesomeIcons.droplet,
                            size: 100.0,
                            color: Color.fromRGBO(228, 44, 3, 1),
                          ),
                          isVerified
                              ? Text(data.bloodGroup,
                                  style: TextStyle(
                                    color: Color.fromRGBO(228, 44, 3, 1),
                                    fontSize: 35,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ))
                              : Text("-- Not Registered --",
                                  style: TextStyle(
                                    color: Color.fromRGBO(228, 44, 3, 1),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  )),
                        ],
                      ),
                    ),
                    Container(
                      height: 230,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(4, 4),
                              blurRadius: 10,
                              color:
                                  Color.fromARGB(125, 7, 2, 2).withOpacity(.5),
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Donor Status",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              )),
                          isVerified
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundColor:
                                      Color.fromRGBO(3, 228, 59, 1),
                                  child: FaIcon(
                                    FontAwesomeIcons.check,
                                    size: 80.0,
                                    color: Color.fromRGBO(237, 242, 238, 1),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  // backgroundColor: Color.fromRGBO(169, 2, 2, 1),
                                  backgroundColor: Color.fromRGBO(9, 8, 8, 1),
                                  child: Text(
                                    "☹️",
                                    style: TextStyle(fontSize: 90),
                                  )
                                  // FaIcon(
                                  //   FontAwesomeIcons.crop,
                                  //   size: 80.0,
                                  //   color: Color.fromRGBO(237, 242, 238, 1),
                                  // ),
                                  ),
                          isVerified
                              ? Text("You Can Donate",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ))
                              : Text("Register First\n   to Donate",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  )),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }
      });
}
