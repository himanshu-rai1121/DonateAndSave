import 'package:donate_platelets/models/User.dart';
import 'package:donate_platelets/providers/information.dart';
import 'package:donate_platelets/providers/users.dart';
import 'package:donate_platelets/screens/BannerScreen.dart';
import 'package:donate_platelets/screens/HomeScreen.dart';
import 'package:donate_platelets/screens/donationForm.dart';
import 'package:donate_platelets/screens/platelet_content_screen.dart';
import 'package:donate_platelets/screens/storyForm.dart';
import 'package:donate_platelets/screens/webview.dart';
import 'package:flutter/material.dart';
import 'package:donate_platelets/constants/color_constants.dart';
import 'package:provider/provider.dart';

import 'dbHelper/mondodb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
            '/banner': (context) => BannerScreen(),
            '/donation': (context) => DonationForm(),
            '/story': (context) => StoryScreen(),
            '/plateletContent': (context) => PlateletContent(),
            '/labs': (context) => WebView(),
          },
          home: BannerScreen(),
        ));
  }
}
