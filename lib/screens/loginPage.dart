import "package:cloud_firestore/cloud_firestore.dart";
import "package:donate_platelets/constants/color_constants.dart";
import "package:donate_platelets/mongoDB/Models/mongoDbUserInfoModel.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../mongoDB/dbHelper/mongodb.dart";
import "../widgets/snackbar.dart";
import "../widgets/submitButtonWithAnimation.dart";
import 'package:mongo_dart/mongo_dart.dart' as M;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  bool isLoginScreen = true;
  void toggleLoginMode() {
    setState(() {
      isLoginScreen = !isLoginScreen;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20))),
                      ),
                      Container(
                        // height: MediaQuery.of(context).size.height / 4,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(142, 237, 219, 22)
                                .withOpacity(0.3),
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(500))),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 2 * 0.4,
                        width: MediaQuery.of(context).size.width / 4 * 3,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(115, 209, 148, 4)
                                .withOpacity(0.2),
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(500))),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isLoginScreen
                                  ? "Sign in to your\nAccount"
                                  : "Sign up to your\nAccount",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              isLoginScreen
                                  ? "Sign in to your Account"
                                  : "Sign up to your Account",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                isLoginScreen
                    ? Login(
                        onToggleMode: toggleLoginMode,
                      )
                    : SignUp(onToggleMode: toggleLoginMode),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  Function() onToggleMode;
  Login({super.key, required this.onToggleMode});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _mailError = null;
  var emailController = new TextEditingController();
  var passController = new TextEditingController();
  bool _isPasswordNotVisible = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your email',
                errorText: _mailError,
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: passController,
              obscureText: _isPasswordNotVisible,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordNotVisible = !_isPasswordNotVisible;
                      });
                    },
                    child: Icon(
                      _isPasswordNotVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: _isPasswordNotVisible ? Colors.grey : Colors.blue,
                    )),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: const Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    color: Color.fromARGB(147, 122, 112, 12),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            CustomMainButton(
                onPressed: () {
                  var a = emailController.text;
                  if (a == null ||
                      !a.contains('@') ||
                      a.lastIndexOf('.') <= a.lastIndexOf('@') + 1) {
                    setState(() {
                      _mailError = "Please enter valid Email address";
                    });
                  } else {
                    _mailError = null;
                    // validate and submit
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passController.text)
                        .then((value) async {
                      // Save the userId to shared preferences
                      String userId = value.user!.uid;
                      // Save the userId to shared preferences
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('userId', userId);

                      // FirebaseUserInfo.setid(value.user!.email!);
                      Navigator.pushNamed(context, "/bottomNavigation");
                    }).onError((error, stackTrace) {
                      print(error.toString());
                      setState(() {
                        _mailError = error.toString();
                      });
                    });
                  }
                },
                buttonName: 'Login'),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 1, // Adjust the height of the line
                  width: MediaQuery.of(context).size.width / 4,
                  color: Colors.grey,
                ),
                Text(
                  "Or login with ",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 1, // Adjust the height of the line
                  color: Colors.grey, // Line color
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                signinMethodButton(
                    imageIconName: 'assets/login/google.png',
                    buttonName: 'Google',
                    ontap: () {}),
                signinMethodButton(
                    imageIconName: 'assets/login/facebook.png',
                    buttonName: 'Facebook',
                    ontap: () {}),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "Don't Have an account ?   ",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget
                        .onToggleMode(); // Call the callback to toggle the mode
                    print("222");
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      color: Color.fromARGB(147, 122, 112, 12),
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<String?> getNameFromFirestore(String userId) async {
  try {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (documentSnapshot.exists) {
      // The document with the given userId exists
      // Access the 'name' field and return its value
      return documentSnapshot.get('name') as String?;
    } else {
      // The document with the given userId does not exist
      return null;
    }
  } catch (e) {
    // Handle any errors that might occur during the process
    print('Error getting name from Firestore: $e');
    return null;
  }
}

Widget signinMethodButton(
    {required String imageIconName,
    required String buttonName,
    required Function ontap}) {
  return GestureDetector(
    onTap: () {
      ontap();
    },
    child: Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Container(
              child: Image.asset(imageIconName, fit: BoxFit.fitHeight),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              buttonName,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )),
  );
}

class SignUp extends StatefulWidget {
  final Function() onToggleMode; // Function to trigger toggle
  SignUp({Key? key, required this.onToggleMode}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _mailError = null;
  var _passError = null;
  var emailController = new TextEditingController();
  var passController = new TextEditingController();
  var confPassController = new TextEditingController();
  var nameController = new TextEditingController();

  bool _isPasswordNotVisible = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your Name',
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your email',
                      errorText: _mailError,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passController,
                    obscureText: _isPasswordNotVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isPasswordNotVisible = !_isPasswordNotVisible;
                            });
                          },
                          child: Icon(
                            _isPasswordNotVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: _isPasswordNotVisible
                                ? Colors.grey
                                : Colors.blue,
                          )),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: confPassController,
                    obscureText: _isPasswordNotVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Conform Password',
                      errorText: _passError,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isPasswordNotVisible = !_isPasswordNotVisible;
                            });
                          },
                          child: Icon(
                            _isPasswordNotVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: _isPasswordNotVisible
                                ? Colors.grey
                                : Colors.blue,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomMainButton(
                      onPressed: () {
                        var a = emailController.text;
                        var b = passController.text;
                        var c = confPassController.text;
                        var isEmailCorrect = false;
                        var isPassCorrect = false;
                        if (a == null ||
                            !a.contains('@') ||
                            a.lastIndexOf('.') <= a.lastIndexOf('@') + 1) {
                          setState(() {
                            _mailError = "Please enter valid Email address";
                          });
                        } else {
                          _mailError = null;
                          isEmailCorrect = true;
                        }
                        if (b != c) {
                          setState(() {
                            _passError = "Password does not match";
                          });
                        } else {
                          _passError = null;
                          isPassCorrect = true;
                        }
                        // now go to the next page if both email and password varification is completed
                        if (isEmailCorrect && isPassCorrect) {
                          // write further

                          // authenticate and create new user in database
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passController.text)
                              .then((value) async {
                            // print(value);
                            print("account created");
                            Navigator.pushNamed(context, '/bottomNavigation');

                            // Store the user name, email and user image in firestore
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(value.user?.uid)
                                .set({
                              'username': nameController.text,
                              'uid': value.user?.uid,
                              'profilePhoto': value.user?.photoURL,
                            });

                            String userId = value.user!
                                .uid; // Save the userId to shared preferences
                            // Save the userId to shared preferences
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('userId', userId);

                            // insert data in mongo database
                            insertData(
                                email: emailController.text,
                                name: nameController.text,
                                userId: value.user!.uid,
                                isVerified: false);
                          }).onError((error, stackTrace) {
                            print("Error ${error.toString()}");
                            setState(() {
                              _mailError = "${error.toString()}";
                              _passError = error.toString();
                            });
                          });
                        }
                      },
                      buttonName: 'Signup'),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 1, // Adjust the height of the line
                        width: MediaQuery.of(context).size.width / 4,
                        color: Colors.grey,
                      ),
                      const Text(
                        "Or Signup using ",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: 1, // Adjust the height of the line
                        color: Colors.grey, // Line color
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      signinMethodButton(
                          imageIconName: 'assets/login/google.png',
                          buttonName: 'Google',
                          ontap: () {}),
                      signinMethodButton(
                          imageIconName: 'assets/login/facebook.png',
                          buttonName: 'Facebook',
                          ontap: () {}),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Already Have an account ?   ",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget
                              .onToggleMode(); // Call the callback to toggle the mode
                          print("222");
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Color.fromARGB(147, 122, 112, 12),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
                ])));
  }

  Future<void> insertData(
      {required String userId,
      required String name,
      required String email,
      required bool isVerified}) async {
    var _id = M.ObjectId(); // it will be used for unique id
    final data = MongoDbUserInfoModel(
        id: _id,
        userId: userId,
        name: name,
        email: email,
        isVerified: isVerified,
        bloodGroup: "",
        dob: "",
        address: "",
        city: "",
        location: "",
        phone: "",
        age: 0,
        healthIssue: "");
    var result = await MongoDatabase.insert(data);
    customSnackBar(context, _id.$oid);
    // _cleaarAll();
  }

  // void _clearAll() {
  //   setState(() {
  //     nameController.text = "";
  //     emailController.text = "";

  //   });
  // }
}
