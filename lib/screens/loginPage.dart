import "package:donate_platelets/constants/color_constants.dart";
import "package:flutter/material.dart";

import "../widgets/submitButtonWithAnimation.dart";

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
  var email = new TextEditingController();
  var pass = new TextEditingController();
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
              controller: email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your email',
                errorText: _mailError,
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: pass,
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
                  var a = email.text;
                  if (a == null ||
                      !a.contains('@') ||
                      a.lastIndexOf('.') <= a.lastIndexOf('@') + 1) {
                    setState(() {
                      _mailError = "Please enter valid Email address";
                    });
                  } else {
                    setState(() {
                      _mailError = null;
                    });
                    // validate and submit
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
  var email = new TextEditingController();
  var pass = new TextEditingController();
  var confPass = new TextEditingController();
  var name = new TextEditingController();

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
                    controller: name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your Name',
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your email',
                      errorText: _mailError,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: pass,
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
                    controller: confPass,
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
                        var a = email.text;
                        var b = pass.text;
                        var c = confPass.text;
                        var isEmailCorrect = false;
                        var isPassCorrect = false;
                        if (a == null ||
                            !a.contains('@') ||
                            a.lastIndexOf('.') <= a.lastIndexOf('@') + 1) {
                          setState(() {
                            _mailError = "Please enter valid Email address";
                          });
                        } else {
                          setState(() {
                            _mailError = null;
                            isEmailCorrect = true;
                          });
                          // validate and submit
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
}
