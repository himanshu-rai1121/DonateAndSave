import 'package:donate_platelets/mongoDB/dbHelper/mongodb.dart';
import 'package:donate_platelets/screens/requests.dart';
import 'package:donate_platelets/widgets/submitButtonWithAnimation.dart';
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../mongoDB/Models/mongoDbDynamicDatabaseModel.dart';
import '../sharedPreference/auth_service.dart';
import '../widgets/drawerWidget.dart';
import 'donationForm.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class SendRequests extends StatefulWidget {
  const SendRequests({super.key});

  @override
  State<SendRequests> createState() => _SendRequestsState();
}

class _SendRequestsState extends State<SendRequests> {
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
            'Send Requests',
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
            getRequest(currUserId, true, selectedIconName),
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

Widget getRequest(String? currUserId, bool isSendRequest, String status) {
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
                    //   return printRequestCard(
                    //       MongoDbDynamicDatabaseModel.fromJson(
                    //           snapshot.data[index]),
                    //       context,
                    //       status);
                    // }),
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
  bool isWithdrawn = false;
  bool isCompleted = false;
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
                "Donor #" +
                    widget.data.donorId
                        .substring(widget.data.donorId.length - 4),
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
            isWithdrawn
                ? Text(
                    "Withdrawn\nsuccessfully",
                    style: TextStyle(
                      color: kPrimaryColor,
                      decoration: TextDecoration.underline,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Container(
                    height: 50,
                    width: 120,
                    // padding: EdgeInsets.all(5),
                    child: CustomMainButton(
                        onPressed: () {
                          _updateStatus(widget.data.id, "Withdraw");
                          setState(() {
                            isWithdrawn = true;
                          });
                        },
                        buttonName: "Withdraw")),
          if (widget.status == "Accepted")
            isCompleted
                ? const Text(
                    "Marked as completed",
                    style: TextStyle(
                      color: kPrimaryColor,
                      decoration: TextDecoration.underline,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : acceptDeclineButton(
                    buttonName: "Mark as Completed",
                    isColoured: true,
                    ontap: () {
                      _updateStatus(widget.data.id, "completed");
                      setState(() {
                        isCompleted = true;
                      });
                    }),
        ]));
  }
}

// Widget printRequestCard(
//     MongoDbDynamicDatabaseModel data, BuildContext context, String status) {
//   return Container(
//       margin: const EdgeInsets.all(10),
//       padding: EdgeInsets.all(10),
//       // height: 200,
//       decoration: BoxDecoration(
//           boxShadow: <BoxShadow>[
//             BoxShadow(
//               offset: Offset(-4, 4),
//               blurRadius: 10,
//               color: Color(0xFF212121).withOpacity(.2),
//             ),
//           ],
//           // color: Colors.amber.shade400,
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(10))),
//       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text(
//               "Donor #" + data.donorId.substring(data.donorId.length - 4),
//               style: TextStyle(
//                 fontSize: 15,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             InkWell(
//               child: const Text(
//                 "View Detail > ",
//                 style: TextStyle(
//                   color: kPrimaryColor,
//                   decoration: TextDecoration.underline,
//                   fontSize: 12,
//                   fontFamily: 'Poppins',
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               onTap: () {
//                 Navigator.pushNamed(context, '/signUp');
//               },
//             ),
//           ],
//         ),
//         if (status == "Active")
//           Container(
//               height: 50,
//               width: 120,
//               // padding: EdgeInsets.all(5),
//               child: CustomMainButton(
//                   onPressed: () {
//                     // _updateStatus(data.id, "Withdraw");
//                   },
//                   buttonName: "Withdraw")),
//       ]));
// }

Future<void> _updateStatus(M.ObjectId id, String status) async {
  var result = MongoDatabase.updateRequestStatus(id, status);
}
