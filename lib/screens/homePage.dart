import 'package:donate_platelets/constants/color_constants.dart';
import 'package:donate_platelets/mongoDB/dbHelper/mongodb.dart';
import 'package:donate_platelets/widgets/card.dart';
import 'package:donate_platelets/widgets/carouselSlider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../mongoDB/Models/mongoDbUserInfoModel.dart';
import '../sharedPreference/auth_service.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.fromLTRB(10, 70, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselWithIndicatorDemo(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomIcon(FontAwesomeIcons.search, "Find Donors", () {
                  Navigator.pushNamed(context, '/findDonor');
                }),
                CustomIcon(FontAwesomeIcons.building, "Nearby Labs", () {
                  Navigator.pushNamed(context, '/labs');
                }),
                CustomIcon(FontAwesomeIcons.tablets, "Increase\nPlatelets", () {
                  Navigator.pushNamed(context, '/plateletContent');
                }),
                // CustomIcon(),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomIcon(FontAwesomeIcons.shareAlt, "Share Your\nStory", () {
                  Navigator.pushNamed(context, '/story');
                }),
                CustomIcon(FontAwesomeIcons.fireExtinguisher,
                    "Mosquito\nFogging", () {}),
                CustomIcon(FontAwesomeIcons.bullhorn, "Campaign", () {}),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            AllDonor(currUserId!),
          ],
        ),
      )),
    );
  }
}

Widget CustomIcon(IconData icon, String title, Function()? ontap) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      height: 100,
      width: 100,
      // width: MediaQuery.of(context).size.width / 2.5,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: Color.fromARGB(126, 10, 10, 10).withOpacity(.5),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            icon,
            size: 30.0,
            color: kPrimaryColor,
          ),
          SizedBox(
            height: 10,
          ),
          Text(title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    ),
  );
}

Widget AllDonor(String currUserId) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.only(left: 15),
        child: Text("Available Donors :",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            )),
      ),
      // list view
      FutureBuilder<List<Map<String, dynamic>>>(
        future: MongoDatabase.allDonorData(
            currUserId), //  fetches data asynchronously
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child:
                    CircularProgressIndicator()); // Show a loading indicator while data is being fetched
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('No data available.');
          } else {
            final dataList = snapshot.data!;

            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                childAspectRatio: 3 / 1.3,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 25.0,
              ),
              physics: NeverScrollableScrollPhysics(),
              itemCount: dataList.length,
              itemBuilder: (BuildContext context, int index) {
                // final item = dataList[index];
                // Use the data from the map to build your list item
                // return ListTile(
                //   title: Text(item[
                //       'title']), // Change 'title' to the key you use in your map
                //   subtitle: Text(item[
                //       'subtitle']), // Change 'subtitle' to the key you use in your map
                //   // Customize the list item appearance as needed
                // );
                return DisplayCard(
                  data: MongoDbUserInfoModel.fromJson(snapshot.data![index]),
                  currUserId: currUserId.toString(),
                );
              },
            );
          }
        },
      ),
    ],
  );
}
