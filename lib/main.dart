import 'package:donate_platelets/models/User.dart';
import 'package:donate_platelets/providers/information.dart';
import 'package:donate_platelets/providers/users.dart';
import 'package:donate_platelets/screens/BannerScreen.dart';
import 'package:donate_platelets/screens/HomeScreen.dart';
import 'package:donate_platelets/screens/edit_profile.dart';
import 'package:donate_platelets/screens/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:donate_platelets/constants/color_constants.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Information(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Users(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme:
            ThemeData(primaryColor: kPrimaryColor, accentColor: kAccentColor),
        home: BannerScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen("A"),
          BannerScreen.routeName: (ctx) => BannerScreen(),
          EditProfile.routeName: (ctx) => EditProfile(),
          StoryScreen.routeName: (ctx) => StoryScreen()
        },
      ),
    );
  }
}
