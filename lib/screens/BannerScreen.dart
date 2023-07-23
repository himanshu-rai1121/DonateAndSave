import 'dart:async';

import 'package:donate_platelets/animation/FadeAnimation.dart';
import 'package:donate_platelets/constants/text_style_constants.dart';
import 'package:donate_platelets/screens/HomeScreen.dart';
import 'package:donate_platelets/screens/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:donate_platelets/constants/color_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../dbHelper/mondodb.dart';

class BannerScreen extends StatelessWidget {
  bool isAlreadyLogin;

  BannerScreen({required this.isAlreadyLogin});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800.0,
      color: kPrimaryColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 55, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeAnimation(
              1.5,
              Container(
                height: 95.0,
                width: 95.0,
                child: Image.asset('assets/images/heart.png'),
              ),
            ),
            FadeAnimation(
              1.6,
              Row(
                children: <Widget>[
                  Text(
                    'Donate',
                    style: kBannerTitleStyle,
                  ),
                  Text(
                    ' Platelet',
                    style: kBannerPlasmaTitleStyle,
                  )
                ],
              ),
            ),
            FadeAnimation(
              1.6,
              Text(
                'Save Life',
                style: kBannerTitleStyle,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            FadeAnimation(
              1.7,
              Text(
                'Help others surviving by donating your platelet. Let\'s fight together to.....',
                style: kBannerSubTitleStyle,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            FadeAnimation(
              1.8,
              Text(
                'SAVE THE WORLD',
                style: kBannerSub02TitleStyle,
              ),
            ),
            SizedBox(
              height: 45.0,
            ),
            FadeAnimation(
              1.8,
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 100.0,
                      height: 40.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isAlreadyLogin) {
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            Navigator.pushReplacementNamed(context, '/login');
                          }
                        },
                        child: Text(
                          'Got it',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              fontFamily: 'Poppins'),
                        ),
                        // color: kBannerBasicColor,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(7.0),
                        // ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class BannerScreen extends StatefulWidget {
//   const BannerScreen({Key? key}) : super(key: key);

//   @override
//   _BannerScreenState createState() => _BannerScreenState();
// }

// class _BannerScreenState extends State<BannerScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 4), () {
//       _loadHomePage();
//     });
//   }

//   Future<void> _loadHomePage() async {
//     await MongoDatabase.connect();

//     Navigator.pushReplacementNamed(context, '/home');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 800.0,
//       color: kPrimaryColor,
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(12, 55, 0, 0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             FadeAnimation(
//               1.5,
//               Container(
//                 height: 95.0,
//                 width: 95.0,
//                 child: Image.asset('assets/images/heart.png'),
//               ),
//             ),
//             FadeAnimation(
//               1.6,
//               Row(
//                 children: <Widget>[
//                   Text(
//                     'Donate',
//                     style: kBannerTitleStyle,
//                   ),
//                   Text(
//                     ' Platelet',
//                     style: kBannerPlasmaTitleStyle,
//                   )
//                 ],
//               ),
//             ),
//             FadeAnimation(
//               1.6,
//               Text(
//                 'Save Life',
//                 style: kBannerTitleStyle,
//               ),
//             ),
//             SizedBox(
//               height: 25.0,
//             ),
//             FadeAnimation(
//               1.7,
//               Text(
//                 'Help others surviving by donating your platelet. Let\'s fight together to.....',
//                 style: kBannerSubTitleStyle,
//               ),
//             ),
//             SizedBox(
//               height: 10.0,
//             ),
//             FadeAnimation(
//               1.8,
//               Text(
//                 'SAVE THE WORLD',
//                 style: kBannerSub02TitleStyle,
//               ),
//             ),
//             SizedBox(
//               height: 45.0,
//             ),
//             // FadeAnimation(
//             //   1.8,
//             //   Padding(
//             //     padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
//             //     child: Row(
//             //       mainAxisAlignment: MainAxisAlignment.end,
//             //       children: <Widget>[
//             //         ButtonTheme(
//             //           minWidth: 100.0,
//             //           height: 40.0,
//             //           child: ElevatedButton(
//             //             onPressed: () {
//             //               Navigator.pushReplacementNamed(context, '/home');
//             //             },
//             //             child: Text(
//             //               'Got it',
//             //               style: TextStyle(
//             //                   color: Theme.of(context).accentColor,
//             //                   fontWeight: FontWeight.bold,
//             //                   fontSize: 20.0,
//             //                   fontFamily: 'Poppins'),
//             //             ),
//             //             // color: kBannerBasicColor,
//             //             // shape: RoundedRectangleBorder(
//             //             //   borderRadius: BorderRadius.circular(7.0),
//             //             // ),
//             //           ),
//             //         )
//             //       ],
//             //     ),
//             //   ),
//             // )
//           ],
//         ),
//       ),
//     );
//   }
// }
