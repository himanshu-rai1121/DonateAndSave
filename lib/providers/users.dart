import 'package:donate_platelets/models/User.dart';
import 'package:flutter/cupertino.dart';

class Users extends ChangeNotifier {
  List<User> _users = [
    User(
        userId: 1,
        userName: 'Himanshu Kumar',
        userDP: 'assets/images/himanshu.png',
        userPhone: '+916377403312',
        userLocation: 'Kaushambi',
        userCity: 'Delhi',
        userBlood: 'A+'),
    User(
        userId: 2,
        userName: 'Soum Srivastava',
        userDP: 'assets/images/soum.png',
        userPhone: '+918707656497',
        userLocation: 'Rohini',
        userCity: 'Delhi',
        userBlood: 'B+'),
    User(
        userId: 3,
        userName: 'Amod Katiyar',
        userDP: 'assets/images/user0.png',
        userPhone: '+917895430513',
        userLocation: 'Rithala',
        userCity: 'Delhi',
        userBlood: 'B+'),
    User(
        userId: 4,
        userName: 'Aman verma',
        userDP: 'assets/images/user0.png',
        userPhone: '+919026565407',
        userLocation: 'Noida',
        userCity: 'Delhi NCR',
        userBlood: 'O-'),
    User(
        userId: 5,
        userName: 'Rahul Yadav',
        userDP: 'assets/images/rahul.png',
        userPhone: '+919919275534',
        userLocation: 'Kashmiri Gate',
        userCity: 'Delhi',
        userBlood: 'AB-'),
    User(
        userId: 6,
        userName: 'Nitish Kumar',
        userDP: 'assets/images/nitish.png',
        userPhone: '+918299587541',
        userLocation: 'Anand Vihar',
        userCity: 'Delhi',
        userBlood: 'A+'),
    User(
        userId: 7,
        userName: 'Priyansh Kapoor',
        userDP: 'assets/images/user0.png',
        userPhone: '+917417876189',
        userLocation: 'Chandini Chowk',
        userCity: 'Delhi',
        userBlood: 'A+'),
    User(
        userId: 8,
        userName: 'Harsh Yadav',
        userDP: 'assets/images/user0.png',
        userPhone: '+917455095859',
        userLocation: 'Shahdara',
        userCity: 'Delhi',
        userBlood: 'A+'),
    User(
        userId: 9,
        userName: 'Naman',
        userDP: 'assets/images/user0.png',
        userPhone: '+919793059577',
        userLocation: 'KarolBagh',
        userCity: 'Delhi',
        userBlood: 'A+'),
    User(
        userId: 10,
        userName: 'Mayank',
        userDP: 'assets/images/user0.png',
        userPhone: '+917282812417',
        userLocation: 'MayurVihar',
        userCity: 'Delhi',
        userBlood: 'A+'),
  ];

  List<User> get userList {
    final baseUserList = [..._users];
    return baseUserList;
  }
}
