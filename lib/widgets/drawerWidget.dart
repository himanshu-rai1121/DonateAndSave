import 'package:donate_platelets/screens/HomeScreen.dart';
import 'package:donate_platelets/screens/edit_profile.dart';
import 'package:donate_platelets/screens/platelet_content_screen.dart';
import 'package:donate_platelets/screens/story_screen.dart';
import 'package:donate_platelets/screens/platelet_content_screen.dart';
import 'package:donate_platelets/screens/webview.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 180.0,
            color: Theme.of(context).primaryColor,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 25, 20, 20),
                  child: Text(
                    'Donate Platelet',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 40.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.home,
              color: Colors.deepPurple.shade700,
            ),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.leaf,
              color: Colors.blueAccent.shade700,
            ),
            title: Text('Be a donor'),
            onTap: () {
              Navigator.of(context).pushNamed(EditProfile.routeName);
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.shareAlt,
              color: Colors.amber.shade300,
            ),
            title: Text('Share your story'),
            onTap: () {
              Navigator.of(context).pushNamed(StoryScreen.routeName);
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.tablets,
              color: Colors.pinkAccent.shade400,
            ),
            title: Text('Ways to Increase Platelet'),
            // onTap: () {},
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PlateletContent()));
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.solidHospital,
              color: Colors.pinkAccent.shade400,
            ),
            title: Text('NearBy Labs'),
            // onTap: () {},
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => WebView()));
            },
          ),
        ],
      ),
    );
  }
}
