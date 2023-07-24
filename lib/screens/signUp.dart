import 'package:donate_platelets/mongoDB/Models/mongoDbUserInfoModel.dart';
import 'package:flutter/material.dart';
import 'package:donate_platelets/widgets/submitButtonWithAnimation.dart';
import 'package:donate_platelets/widgets/textInputBox.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

import '../constants/color_constants.dart';
import '../mongoDB/dbHelper/mongodb.dart';
import '../sharedPreference/auth_service.dart';
import '../widgets/drawerWidget.dart';
import '../widgets/snackbar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? userId = "";

  @override
  void initState() {
    super.initState();
    // Get the user ID when the app starts
    getUserId();
  }

  void getUserId() async {
    String? userId = await AuthService.getUserIdFromSharedPrefs();
    setState(() {
      this.userId = userId;
    });
  }

  var nameController = new TextEditingController();
  var healthController = new TextEditingController();
  var ageController = new TextEditingController();
  var bloodGroupController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Find Donor',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.short_text,
            size: 40,
            color: kAccentColor,
          ),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/donation');
            },
            icon: Icon(
              Icons.pan_tool,
              size: 25,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sign Up :",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextInput(
                  labelText: "Full NAME",
                  hintText: 'Enter your full name',
                  icon: Icons.person,
                  controller: nameController,
                ),

                const SizedBox(
                  height: 10,
                ),
                TextInput(
                    hintText: "Age",
                    icon: Icons.date_range,
                    controller: ageController,
                    labelText: "your age"),
                const SizedBox(
                  height: 10,
                ),
                TextInput(
                    hintText: "Any health issue",
                    icon: Icons.medical_information,
                    controller: healthController,
                    labelText: "Prevailing Health Condition"),
                const SizedBox(
                  height: 10,
                ),
                TextInput(
                  hintText: "A+, A-, B+, B-, .....",
                  icon: Icons.feedback,
                  controller: bloodGroupController,
                  labelText: "Blood Group",
                  // mnsize: 4,
                  // mxsize: 8,
                ),
                const SizedBox(
                  height: 50,
                ),

                //  custom submit button Created
                CustomMainButton(
                  onPressed: () {
                    FocusScope.of(context)
                        .unfocus(); // on press submit button push down the keyboard
                    // print(await AuthService.getUserIdFromSharedPrefs());
                    print(userId);
                    print(userId);
                    print(userId);
                    print(userId);
                    _updateStudentName(
                        userId.toString(),
                        "",
                        "",
                        true,
                        bloodGroupController.text,
                        ageController.text,
                        "",
                        "",
                        "",
                        "",
                        18,
                        healthController.text);
                    // _insertData(
                    // name.text, feedback.text, currLang.text, futureLang.text);
                    // Navigator.pop(context);
                  },
                  buttonName: 'Register',
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  Future<void> _updateStudentName(
      String userId,
      String name,
      String email,
      bool isVerified,
      String bloodGroup,
      String dob,
      String address,
      String city,
      String location,
      String phone,
      int age,
      String healthIssue) async {
    final data = MongoDbUserInfoModel(
        id: M.ObjectId(),
        userId: userId,
        name: name,
        email: email,
        isVerified: isVerified,
        bloodGroup: bloodGroup,
        dob: dob,
        address: address,
        city: city,
        location: location,
        phone: phone,
        age: age,
        healthIssue: healthIssue);
    var result = await MongoDatabase.update(data);
    customSnackBar(context, userId);
    _clearAll();
  }

  void _clearAll() {
    nameController.text = "";
    ageController.text = "";
    healthController.text = "";
    bloodGroupController.text = "";
  }
}
