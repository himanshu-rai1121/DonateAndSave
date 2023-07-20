import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class TextInput extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final String labelText;
  TextEditingController controller = new TextEditingController();
  var mnsize;
  var mxsize;

  TextInput(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.controller,
      required this.labelText,
      this.mnsize,
      this.mxsize});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              labelText,
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
            )),
        SizedBox(
          height: 5,
        ),
        Container(
          // height: 50,
          margin: const EdgeInsetsDirectional.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.06),
                  offset: const Offset(0, 4))
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 3, 5, 3),
            child: Row(
              children: [
                CircleAvatar(
                  // Color.fromARGB(199, 141, 9, 178),
                  backgroundColor: kPrimaryColor,
                  radius: 18.0,
                  child: Icon(
                    icon,
                    color: const Color.fromARGB(255, 240, 241, 243),
                    size: 22.0,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextField(
                      controller: controller,
                      minLines: mnsize,
                      maxLines: mxsize,
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
