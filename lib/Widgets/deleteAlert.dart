import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/colors.dart';
import '../Constants/functions.dart';
import '../Provider/main_provider.dart';

deleteTask(BuildContext context, int id) {
  MainProvider taskProvider = Provider.of<MainProvider>(context, listen: false);
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: basewhite,
    scrollable: true,
    title: Center(
      child: Column(
        children: [
          const Text(
            "Are you sure",
            style: TextStyle(
                fontFamily: 'Muli-SemiBold',
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          const Text(
            "want to delete?",
            style: TextStyle(
                fontFamily: 'Muli-SemiBold',
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    blurRadius: 0.1, color: Colors.grey, spreadRadius: 0.1)
              ],
            ),
            child: CircleAvatar(
              radius: 29.0,
              backgroundColor: basewhite,
              child: const Center(
                  child: Icon(
                Icons.delete,
                color: Colors.black,
              )),
            ),
          )
        ],
      ),
    ),
    content: SizedBox(
      height: 50,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      await taskProvider.deleteTask(context, id);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('Yes',
                          style: TextStyle(
                              fontSize: 13,
                              color: basewhite,
                              fontFamily: "Muli-SemiBold")),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      finish(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'No',
                        style: TextStyle(color: basewhite, fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
