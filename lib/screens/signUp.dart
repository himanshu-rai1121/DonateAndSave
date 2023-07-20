import 'package:flutter/material.dart';
import 'package:donate_platelets/widgets/submitButtonWithAnimation.dart';
import 'package:donate_platelets/widgets/textInputBox.dart';

import '../constants/color_constants.dart';
import '../widgets/drawerWidget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var name = new TextEditingController();
  var health = new TextEditingController();
  var age = new TextEditingController();
  var bloodGroup = new TextEditingController();
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
                  controller: name,
                ),

                const SizedBox(
                  height: 10,
                ),
                TextInput(
                    hintText: "Age",
                    icon: Icons.date_range,
                    controller: age,
                    labelText: "your age"),
                const SizedBox(
                  height: 10,
                ),
                TextInput(
                    hintText: "Any health issue",
                    icon: Icons.medical_information,
                    controller: health,
                    labelText: "Prevailing Health Condition"),
                const SizedBox(
                  height: 10,
                ),
                TextInput(
                  hintText: "A+, A-, B+, B-, .....",
                  icon: Icons.feedback,
                  controller: bloodGroup,
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
}
