import 'package:flutter/material.dart';

Widget loginTitleWidget(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;

  double textSize = width > 700 ? 22 : width * 0.04;
  double textWidth = width > 700 ? 12 : width * 0.03;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Login",
        style:
            TextStyle(fontSize: textWidth * 3.5, fontWeight: FontWeight.bold),
      ),
      Text(
        "Please sign in to continue",
        style: TextStyle(
            fontSize: textWidth * 1.2,
            fontWeight: FontWeight.w500,
            color: Colors.grey),
      ),
    ],
  );
}
