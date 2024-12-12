import 'package:flutter/material.dart';
import 'package:new_machine_test/Constants/colors.dart';

Widget login_button(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;

  double textSize = width > 700 ? 22 : width * 0.04;
  double textWidth = width > 700 ? 12 : width * 0.03;
  return Padding(
    padding: const EdgeInsets.only(right: 20),
    child: Align(
      alignment: Alignment.bottomRight,
      child: Container(
        width: width * 0.31,
        decoration: BoxDecoration(
            color: newBlue,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        padding: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
        child: Row(
          children: [
            Text(
              "LOGIN",
              style: TextStyle(fontSize: textSize * 1.1, color: basewhite),
            ),
            SizedBox(
              width: width * 0.01,
            ),
            Icon(
              Icons.arrow_forward,
              color: basewhite,
            )
          ],
        ),
      ),
    ),
  );
}
