import 'package:donate_platelets/constants/color_constants.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            height: 900,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2.5,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(40))),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 90, 20, 0),
                          // height: 120,
                          child: Row(
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
                                  Text("Himanshu",
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                              CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(24, 131, 118, 18),
                                  // Color.fromARGB(252, 243, 221, 55),
                                  radius: 60.0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipRRect(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 30, 20, 20),
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/heart.png'),
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
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 230,
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(4, 4),
                                      blurRadius: 10,
                                      color: Color.fromARGB(126, 10, 10, 10)
                                          .withOpacity(.5),
                                    ),
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                  SizedBox(
                                    // to adjust the height and make both card on same level
                                    height: 10,
                                  )
                                  // Text("You Can Donate",
                                  //     style: TextStyle(
                                  //       color: Colors.grey,
                                  //       fontSize: 12,
                                  //       fontFamily: 'Poppins',
                                  //       fontWeight: FontWeight.w600,
                                  //     )),
                                ],
                              ),
                            ),
                            Container(
                              height: 230,
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(4, 4),
                                      blurRadius: 10,
                                      color: Color.fromARGB(125, 7, 2, 2)
                                          .withOpacity(.5),
                                    ),
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Donor Status",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      )),
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor:
                                        Color.fromRGBO(3, 228, 59, 1),
                                    child: FaIcon(
                                      FontAwesomeIcons.check,
                                      size: 80.0,
                                      color: Color.fromRGBO(237, 242, 238, 1),
                                    ),
                                  ),
                                  Text("You Can Donate",
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
                        SizedBox(height: 10),
                        UpcomingEventCard(
                          title: "Blood Donation Drive",
                          date: "Aug 15, 2023",
                          location: "Community Center",
                        ),
                        UpcomingEventCard(
                          title: "Health Awareness Seminar",
                          date: "Sep 10, 2023",
                          location: "City Hall",
                        ),
                      ],
                    )
                  ],
                ),
                // Expanded(
                //   child: Cards(
                //     bloodGroup: "A+",
                //     toFindAll: true,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget UpcomingEventCard(
    {required String title, required String date, required String location}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 2),
          blurRadius: 5,
          color: Colors.black.withOpacity(0.1),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          date,
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 5),
        Text(
          location,
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
