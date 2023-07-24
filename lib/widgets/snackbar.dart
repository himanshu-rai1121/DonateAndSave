// present in donationform.dart
import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(
    BuildContext context, String id) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green),
            SizedBox(width: 10),
            Expanded(child: Text("Inserted id " + id)),
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
}
