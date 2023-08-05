import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Function to get the user ID from shared preferences
  static Future<String?> getUserIdFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  // Other authentication related methods can be added here
}



//  String userId = value.user!.uid;
//                       // Save the userId to shared preferences
//                       SharedPreferences prefs =
//                           await SharedPreferences.getInstance();
//                       prefs.setString('userId', userId);