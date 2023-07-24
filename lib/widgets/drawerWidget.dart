import 'package:donate_platelets/screens/HomeScreen.dart';
import 'package:donate_platelets/screens/donationForm.dart';
import 'package:donate_platelets/screens/platelet_content_screen.dart';
import 'package:donate_platelets/screens/storyForm.dart';
import 'package:donate_platelets/screens/platelet_content_screen.dart';
import 'package:donate_platelets/screens/webview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false, // remove all other routes
              );
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.leaf,
              color: Colors.blueAccent.shade700,
            ),
            title: Text('Be a donor'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/donation');
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.shareAlt,
              color: Colors.amber.shade300,
            ),
            title: Text('Share your story'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/story');
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
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/plateletContent');
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
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/labs');
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.solidHospital,
              color: Colors.pinkAccent.shade400,
            ),
            title: Text('History'),
            // onTap: () {},
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/history');
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.solidHospital,
              color: Colors.pinkAccent.shade400,
            ),
            title: Text('Find Donor'),
            // onTap: () {},
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/findDonor');
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.solidHospital,
              color: Colors.pinkAccent.shade400,
            ),
            title: Text('Requests'),
            // onTap: () {},
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/requests');
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.solidHospital,
              color: Colors.pinkAccent.shade400,
            ),
            title: Text('Login'),
            // onTap: () {},
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/login');
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.solidHospital,
              color: Colors.pinkAccent.shade400,
            ),
            title: Text('Logout'),
            // onTap: () {},
            onTap: () {
              _signOut(context);
            },
          ),
        ],
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
