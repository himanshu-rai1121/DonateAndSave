import 'package:donate_platelets/models/User.dart';
import 'package:donate_platelets/providers/information.dart';
import 'package:donate_platelets/screens/BannerScreen.dart';
import 'package:donate_platelets/screens/HomeScreen.dart';
import 'package:donate_platelets/screens/donationForm.dart';
import 'package:donate_platelets/screens/donor.dart';
import 'package:donate_platelets/screens/findDonor.dart';
import 'package:donate_platelets/screens/history.dart';
import 'package:donate_platelets/screens/loginPage.dart';
import 'package:donate_platelets/screens/platelet_content_screen.dart';
import 'package:donate_platelets/screens/profilePage.dart';
import 'package:donate_platelets/screens/requests.dart';
import 'package:donate_platelets/screens/sendRequests.dart';
import 'package:donate_platelets/screens/register.dart';
import 'package:donate_platelets/screens/storyForm.dart';
import 'package:donate_platelets/screens/viewDonorList.dart';
import 'package:donate_platelets/screens/webview.dart';
import 'package:donate_platelets/widgets/bottomNavigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:donate_platelets/constants/color_constants.dart';
import 'package:provider/provider.dart';

import 'dbHelper/mondodb.dart';
import 'mongoDB/dbHelper/mongodb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await MongoDatabase.connect();
  await MongoDatabase.connect();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Information()),
          // Add more providers here if needed
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme:
              ThemeData(primaryColor: kPrimaryColor, accentColor: kAccentColor),
          debugShowCheckedModeBanner: false,
          routes: {
            '/home': (context) => HomeScreen(),
            // '/banner': (context) => BannerScreen(),
            '/donation': (context) => DonationForm(),
            '/story': (context) => StoryScreen(),
            '/plateletContent': (context) => PlateletContent(),
            '/labs': (context) => WebView(),
            '/history': (context) => History(),
            '/findDonor': (context) => FindDonor(),
            "/donor": (context) => Donor(),
            '/register': (context) => Register(),
            '/requests': (context) => Requests(),
            '/sendRequests': (context) => SendRequests(),
            '/login': (context) => LoginPage(),
            '/profile': (context) => ProfilePage(),
            '/viewDonorList': (context) => ViewDonorList(
                  bloodGroup: 'A+',
                ),
            '/bottomNavigation': (context) => BottomNavigation(),
          },
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData) {
                return BannerScreen(
                  isAlreadyLogin: true,
                );
              }
              return BannerScreen(isAlreadyLogin: false);
            },
          ),
        ));
  }
}
