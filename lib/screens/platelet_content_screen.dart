import 'package:donate_platelets/animation/FadeAnimation.dart';
import 'package:donate_platelets/constants/color_constants.dart';
import 'package:donate_platelets/screens/edit_profile.dart';
import 'package:donate_platelets/widgets/drawerWidget.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';

class PlateletContent extends StatelessWidget {
  // static const routeName = '/stor';
  const PlateletContent({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    String name;

    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Center(
          child: Text(
            'Increase Platelet',
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
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProfile.routeName);
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
        child: Container(
          child: Column(
            children: <Widget>[
              FadeAnimation(
                1.0,
                Container(
                  margin: EdgeInsetsDirectional.only(top: 20),
                  height: 180.0,
                  child: Image.asset('assets/images/veg.jpg'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                        1.8,
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                offset: Offset(-4, 4),
                                blurRadius: 10,
                                color: Color(0xFFFFBF05).withOpacity(.6),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: Color(0xFFFFBF05).withOpacity(.10),
                                  ))),
                                  child: Text(
                                    'That being said, if you are looking for how to increase platelet counts naturally, then the list of foods below should help you to some extent. :',
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                // Container(
                                //   padding: EdgeInsets.only(
                                //     top: 35.0,
                                //     bottom: 35,
                                //   ),
                                //   decoration: BoxDecoration(
                                //     border: Border(
                                //       bottom: BorderSide(
                                //         color:
                                //             Color(0xFFFFBF05).withOpacity(.10),
                                //       ),
                                //     ),
                                //   ),
                                //   child: TextField(
                                //     decoration: InputDecoration(
                                //       border: InputBorder.none,
                                //       hintText: " Your Story",
                                //       hintStyle: TextStyle(
                                //         color: Colors.grey[400],
                                //         fontFamily: 'Poppins',
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                      1.8,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              offset: Offset(-4, 4),
                              blurRadius: 10,
                              color: Color(0xFFFFBF05).withOpacity(.6),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: Color(0xFFFFBF05).withOpacity(.10),
                                ))),
                                child: Text(
                                  '1. Milk',
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: Color(0xFFFFBF05).withOpacity(.10),
                                ))),
                                child: Text(
                                  'We all know that milk is a rich source of calcium and protein and is important in maintaining the strength of bones and muscles in our body. What is even more interesting is that milk contains vitamin K, which is an essential vitamin in the blood clotting mechanism in our body. Furthermore, it is believed that regular consumption of milk may help in improving total blood platelet counts. So, if you are looking for home remedies to increase platelets, make sure you have a glass of milk regularly.',
                                  textAlign: TextAlign.justify,
                                  textScaleFactor: 0.8,
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                      1.8,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              offset: Offset(-4, 4),
                              blurRadius: 10,
                              color: Color(0xFFFFBF05).withOpacity(.6),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: Color(0xFFFFBF05).withOpacity(.10),
                                ))),
                                child: Text(
                                  '2. Papaya Leaf Extract:',
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: Color(0xFFFFBF05).withOpacity(.10),
                                ))),
                                child: Text(
                                  'This is probably the most well-known remedy for low platelet counts. If you are looking for how to increase platelet count during dengue fever, then consuming a glass or two of papaya leaf extract regularly can do the trick. It is not clear how this really works, but clinical trials have clearly demonstrated a significant benefit of papaya leaf extract in increasing platelet counts in viral fever.However, the juice of papaya leaf can be rather bitter and some people experience nausea and possibly even vomiting at times. In such a situation, oral medication in the form of capsules is now available in India that contains the same quantity of extract needed to boost up platelet counts.',
                                  textAlign: TextAlign.justify,
                                  textScaleFactor: 0.8,
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                      1.8,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              offset: Offset(-4, 4),
                              blurRadius: 10,
                              color: Color(0xFFFFBF05).withOpacity(.6),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: Color(0xFFFFBF05).withOpacity(.10),
                                ))),
                                child: Text(
                                  '3. Wheatgrass:',
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: Color(0xFFFFBF05).withOpacity(.10),
                                ))),
                                child: Text(
                                  'Wheatgrass contains high levels of chlorophyll that is structurally similar to the haemoglobin in our blood. It is extremely beneficial when it comes to boosting platelet count, but has additional benefits of increasing the total quantity of red blood cells and white blood cells in the blood. Freshly made wheatgrass juice can be extremely useful if you are looking for how to increase platelet count during chemotherapy.A low platelet count can be of concern. If you are looking for how to increase platelet count naturally, then try and indulge in these foods now and again. However, if there is a medical reason for the low platelet count, then you may want to speak to a haematologist (blood specialist) regarding getting tested to determine the cause of the problem.',
                                  textAlign: TextAlign.justify,
                                  textScaleFactor: 0.8,
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                      2,
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: MaterialButton(
                          minWidth: 300,
                          child: Text(
                            "Home",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomeScreen(name)));
                          },
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
