import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../mongoDB/Models/mongoDbDynamicDatabaseModel.dart';
import '../mongoDB/dbHelper/mongodb.dart';
import '../sharedPreference/auth_service.dart';
import '../widgets/drawerWidget.dart';
import '../widgets/snackbar.dart';
import 'donationForm.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  String? currUserId = "";

  @override
  void initState() {
    super.initState();
    // Get the user ID when the app starts
    getUserId();
  }

  void getUserId() async {
    String? currUserId = await AuthService.getUserIdFromSharedPrefs();
    setState(() {
      this.currUserId = currUserId;
    });
  }

  String selectedIconName = "Active";
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Incoming Requests',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: const Icon(
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
      body: Container(
        // margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-4, 4),
                      blurRadius: 10,
                      color: Color(0xFF212121).withOpacity(.2),
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  activeAcceptedRejected(
                      selectedIconName: selectedIconName,
                      iconName: "Active",
                      ontap: () {
                        setState(() {
                          selectedIconName = "Active";
                        });
                      }),
                  activeAcceptedRejected(
                      selectedIconName: selectedIconName,
                      iconName: "Accepted",
                      ontap: () {
                        setState(() {
                          selectedIconName = "Accepted";
                        });
                      }),
                  activeAcceptedRejected(
                      selectedIconName: selectedIconName,
                      iconName: "Rejected",
                      ontap: () {
                        setState(() {
                          selectedIconName = "Rejected";
                        });
                      })
                ],
              ),
            ),
            // getRequest("Active", context)
            getRequest(currUserId, false, selectedIconName, context),
          ],
        ),
      ),
    );
  }
}

Widget activeAcceptedRejected(
    {required String selectedIconName,
    required String iconName,
    required Function ontap}) {
  return GestureDetector(
    child: Container(
      // height: 50,
      child: Text(
        iconName,
        style: TextStyle(
          color: selectedIconName == iconName ? kPrimaryColor : null,
          decoration:
              selectedIconName == iconName ? TextDecoration.underline : null,
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    onTap: () {
      ontap();
    },
  );
}

Widget getRequest(String? currUserId, bool isSendRequest, String status,
    BuildContext context) {
  return FutureBuilder(
      future: MongoDatabase.getRequests(
          currUserId: currUserId, isSendRequest: isSendRequest, status: status),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            var totalData = snapshot.data.length;
            print("total Data" + totalData.toString());
            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return PrintRequestCard(
                        data: MongoDbDynamicDatabaseModel.fromJson(
                            snapshot.data[index]),
                        status: status);
                  }),
            );
          } else if (snapshot.hasError) {
            // Handle the case when there's an error fetching data
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            // Handle the case when there's no data
            return Center(
              child: Text("No data available"),
            );
          }
        }
      });
}

class PrintRequestCard extends StatefulWidget {
  MongoDbDynamicDatabaseModel data;
  // BuildContext context;
  String status;
  PrintRequestCard(
      {super.key,
      required this.data,
      // required this.context,
      required this.status});

  @override
  State<PrintRequestCard> createState() => _PrintRequestCardState();
}

class _PrintRequestCardState extends State<PrintRequestCard> {
  String acceptStatus = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        // height: 200,
        decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: Offset(-4, 4),
                blurRadius: 10,
                color: Color(0xFF212121).withOpacity(.2),
              ),
            ],
            // color: Colors.amber.shade400,
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Requester #" +
                    widget.data.requesterId
                        .substring(widget.data.requesterId.length - 4),
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                child: const Text(
                  "View Detail > ",
                  style: TextStyle(
                    color: kPrimaryColor,
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/signUp');
                },
              ),
            ],
          ),
          if (widget.status == "Active")
            acceptStatus == ""
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      acceptDeclineButton(
                          buttonName: "Accept",
                          isColoured: true,
                          ontap: () {
                            _updateStatus(widget.data.id, "Accepted");
                            setState(() {
                              acceptStatus = "Accepted";
                            });
                          }),
                      acceptDeclineButton(
                          buttonName: "Decline",
                          isColoured: false,
                          ontap: () {
                            _updateStatus(widget.data.id, "Rejected");
                            setState(() {
                              acceptStatus = "Rejected";
                            });
                          }),
                    ],
                  )
                : Text(
                    acceptStatus,
                    style: const TextStyle(
                      color: kPrimaryColor,
                      decoration: TextDecoration.underline,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
        ]));
  }
}

Future<void> _updateStatus(M.ObjectId id, String status) async {
  var result = MongoDatabase.updateRequestStatus(id, status);
}

Widget acceptDeclineButton(
    {required String buttonName,
    required bool isColoured,
    required Function ontap}) {
  return GestureDetector(
    onTap: () {
      ontap();
    },
    child: Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black54),
        borderRadius: BorderRadius.circular(15),
        gradient: isColoured
            ? LinearGradient(
                colors: [
                  Colors.orangeAccent,
                  Colors.yellow,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white12,
                ],
              ),
      ),
      child: Text(
        buttonName,
        style: TextStyle(
          color: isColoured ? Colors.white : null,
          fontSize: 15,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
