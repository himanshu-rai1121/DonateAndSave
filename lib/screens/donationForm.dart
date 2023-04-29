import 'package:donate_platelets/animation/FadeAnimation.dart';
import 'package:donate_platelets/constants/color_constants.dart';
import 'package:donate_platelets/dbHelper/mondodb.dart';
import 'package:donate_platelets/models/mongoDbDonerModel.dart';
import 'package:donate_platelets/screens/HomeScreen.dart';
import 'package:donate_platelets/widgets/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class DonationForm extends StatefulWidget {
  static const routeName = '/edit';

  @override
  State<DonationForm> createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  var nameCtr = new TextEditingController();
  var bloodCtr = new TextEditingController();
  var phoneCtr = new TextEditingController();
  var addressCtr = new TextEditingController();
  var cityCtr = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    String name;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Center(
          child: Text(
            'Be a donor',
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
            onPressed: () {},
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
                  height: 150.0,
                  child: Image.asset('assets/images/appr.png'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: .2, left: 35, right: 35),
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
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xFFFFBF05).withOpacity(.10),
                                  ),
                                ),
                              ),
                              child: TextField(
                                controller: nameCtr,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xFFFFBF05).withOpacity(.10),
                                  ),
                                ),
                              ),
                              child: TextField(
                                controller: bloodCtr,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Blood Group",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xFFFFBF05).withOpacity(.10),
                                  ),
                                ),
                              ),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: phoneCtr,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Phone number",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: addressCtr,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Address",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: cityCtr,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "City",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                      2,
                      MaterialButton(
                        minWidth: 300,
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        onPressed: () {
                          FocusScope.of(context)
                              .unfocus(); // on press submit button push down the keyboard
                          _insertData(nameCtr.text, bloodCtr.text,
                              phoneCtr.text, addressCtr.text, cityCtr.text);
                        },
                        color: Theme.of(context).primaryColor,
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

  Future<void> _insertData(String name, String bloodGroup, String phone,
      String address, String city) async {
    var _id = M.ObjectId();
    final data = MongoDbDonerModel(
        id: _id,
        name: name,
        bloodGroup: bloodGroup,
        phone: phone,
        address: address,
        city: city);
    var result = await MongoDatabase.insert(data);
    print(result);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.green),
              SizedBox(width: 10),
              Expanded(child: Text("Inserted id " + _id.$oid)),
            ],
          ),
        ),
        backgroundColor: Colors.grey[900],
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        action: SnackBarAction(
          label: "Undo",
          textColor: Colors.white,
          onPressed: () {
            // Delete data from database
          },
        ),
      ),
    );
    _clearAll();
  }

  void _clearAll() {
    nameCtr.text = "";
    bloodCtr.text = "";
    phoneCtr.text = "";
    addressCtr.text = "";
    cityCtr.text = "";
  }
}
