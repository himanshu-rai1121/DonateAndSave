import 'package:donate_platelets/animation/FadeAnimation.dart';
import 'package:donate_platelets/constants/color_constants.dart';
import 'package:donate_platelets/screens/donationForm.dart';
import 'package:donate_platelets/screens/web.dart';
import 'package:donate_platelets/widgets/drawerWidget.dart';
import 'package:flutter/material.dart';

class WebView extends StatelessWidget {
  const WebView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Center(
          child: Text(
            'NearBy Labs',
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
              Navigator.of(context).pushNamed(DonationForm.routeName);
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
                  child: Image.asset('assets/images/microscope.png'),
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
                                    'Available Labs 🏩',
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Image.asset('assets/images/lalpath.png'),
                                    Container(
                                        width: 130,
                                        child: Image.asset(
                                          'assets/images/lalpath.png',
                                          fit: BoxFit.contain,
                                        )),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Dr.Lal PathLabs',
                                          textAlign: TextAlign.justify,
                                          textScaleFactor: 0.8,
                                          style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                            fontSize: 22,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        MaterialButton(
                                          height: 40,
                                          minWidth: 90,
                                          color: Colors.teal,
                                          textColor: Colors.white,
                                          child: new Text("Book A Test"),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LalPathLab()),
                                            );
                                          },
                                        ),
                                        // Text(
                                        //   'aa',
                                        //   textAlign: TextAlign.justify,
                                        //   textScaleFactor: 0.8,
                                        //   style: TextStyle(
                                        //     color: Colors.deepPurple,
                                        //     fontWeight: FontWeight.w300,
                                        //     fontFamily: 'Poppins',
                                        //     fontSize: 18,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Image.asset('assets/images/redcliff.png'),
                                    Container(
                                        width: 130,
                                        child: Image.asset(
                                          'assets/images/redcliff.png',
                                          fit: BoxFit.contain,
                                        )),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Redcliffe Labs',
                                          textAlign: TextAlign.justify,
                                          textScaleFactor: 0.8,
                                          style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                            fontSize: 22,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        MaterialButton(
                                          height: 40,
                                          minWidth: 90,
                                          color: Colors.teal,
                                          textColor: Colors.white,
                                          child: new Text("Book A Test"),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RedCliffLab()),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Image.asset('assets/images/drop1.png'),
                                    Container(
                                        width: 120,
                                        child: Image.asset(
                                          'assets/images/apollo.png',
                                          fit: BoxFit.contain,
                                        )),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Apollo Diagnostics',
                                          textAlign: TextAlign.justify,
                                          textScaleFactor: 0.8,
                                          style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                            fontSize: 22,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        MaterialButton(
                                          height: 40,
                                          minWidth: 90,
                                          color: Colors.teal,
                                          textColor: Colors.white,
                                          child: new Text("Book A Test"),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Apollo()),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        width: 130,
                                        child: Image.asset(
                                          'assets/images/max.png',
                                          fit: BoxFit.contain,
                                        )),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Max Lab',
                                          textAlign: TextAlign.justify,
                                          textScaleFactor: 0.8,
                                          style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                            fontSize: 22,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        MaterialButton(
                                          height: 40,
                                          minWidth: 90,
                                          color: Colors.teal,
                                          textColor: Colors.white,
                                          child: new Text("Book A Test"),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MaxLab()),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
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
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => HomeScreen(name)));
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
