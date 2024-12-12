import 'package:flutter/material.dart';
import 'package:new_machine_test/Provider/main_provider.dart';
import 'package:provider/provider.dart';

import '../Constants/colors.dart';

Widget loginTextFormFieldWidget(
  BuildContext context,
  TextEditingController controller,
  String label,
  String errorText,
  String? Function(String?)? validator,
) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  double textSize = width > 700 ? 22 : width * 0.04;
  double textWidth = width > 700 ? 12 : width * 0.03;
  MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Consumer<MainProvider>(builder: (context, value, child) {
        return TextFormField(
          controller: controller,
          obscureText: label == 'Password'
              ? value.password
                  ? false
                  : true
              : false,
          decoration: InputDecoration(
            suffixIcon: label == 'Password'
                ? IconButton(
                    icon: value.password
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                    onPressed: () {
                      mainProvider.toggleVisibility();
                    },
                  )
                : null,
            labelText: label,
            hintText: label,
            labelStyle: TextStyle(fontSize: textWidth),
            hintStyle: TextStyle(fontSize: textWidth, color: Colors.grey),
            errorText: errorText.isNotEmpty ? errorText : null,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 2.0,
              ),
            ),
          ),
          validator: validator,
        );
      }),
    ),
  );
}

Widget textFormFieldWidget(
  BuildContext context,
  TextEditingController controller,
  String label,
) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  double textSize = width > 700 ? 22 : width * 0.04;
  double textWidth = width > 700 ? 12 : width * 0.03;
  MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Consumer<MainProvider>(builder: (context, value, child) {
      return TextFormField(
        controller: controller,
        obscureText: label == 'Password'
            ? value.password
                ? false
                : true
            : false,
        decoration: InputDecoration(
          suffixIcon: label == 'Password'
              ? IconButton(
                  icon: value.password
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  onPressed: () {
                    mainProvider.toggleVisibility();
                  },
                )
              : null,
          labelText: label,
          hintText: label,
          labelStyle: TextStyle(fontSize: textWidth),
          hintStyle: TextStyle(fontSize: textWidth, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderGrey),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderGrey),
              borderRadius: BorderRadius.all(Radius.circular(30))),
        ),
      );
    }),
  );
}
