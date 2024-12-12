import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constants/colors.dart';
import '../../Constants/functions.dart';
import '../../Provider/main_provider.dart';
import '../login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: basewhite,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: height * 0.3,
                child: Container(
                  decoration: BoxDecoration(
                    color: newBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 40,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.05,
                ),
                InkWell(
                    onTap: () {
                      finish(context);
                    },
                    child: Icon(
                      Icons.keyboard_arrow_left_sharp,
                      color: basewhite,
                      size: 30,
                    )),
                SizedBox(
                  width: width * 0.03,
                ),
                Text(
                  'Profile',
                  style: TextStyle(color: basewhite, fontSize: 18),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 130),
              child: Container(
                height: height / 1.4,
                width: width / 1.2,
                decoration: BoxDecoration(
                  color: basewhite,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.15,
            child: Container(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Consumer<MainProvider>(builder: (context, value, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundColor: basewhite,
                            radius: 50,
                            child: value.profileImage != null
                                ? ClipOval(
                                    child: Image.network(
                                      value.profileImage!,
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    ),
                                  )
                                : Icon(Icons.person, size: 30),
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60, right: 60),
                    child: Row(
                      children: [dataWidget(context)],
                    ),
                  ),
                  SizedBox(height: height * 0.3),
                  InkWell(
                    onTap: () async {
                      logOutAlert(context);
                    },
                    child: Container(
                      width: width / 2.3,
                      height: height * 0.06,
                      decoration: BoxDecoration(
                        color: basewhite,
                        border: Border.all(color: basewhite),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              color: myBlue,
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 14,
                                color: myBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget iconsWidget(BuildContext context, IconData icon) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(height: height * 0.07, child: Icon(icon)),
    );
  }

  Widget dataWidget(BuildContext context) {
    return Consumer<MainProvider>(builder: (context, value, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dataWidget1(context, 'Name', value.name!),
          dataWidget1(context, 'Position', value.position!),
        ],
      );
    });
  }
}

Widget dataWidget1(BuildContext context, String title, String content) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;

  double textSize = width > 700 ? 22 : width * 0.04;
  double textWidth = width > 700 ? 12 : width * 0.03;
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: SizedBox(
      height: height * 0.07,
      width: width * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                TextStyle(fontWeight: FontWeight.w600, fontSize: textWidth + 4),
          ),
          Text(
            content,
            style: TextStyle(fontSize: textWidth),
          ),
        ],
      ),
    ),
  );
}

logOutAlert(BuildContext context) {
  MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
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
            "want to log out?",
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
                  Icons.logout,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    ),
    content: SizedBox(
      height: 50,
      child: SingleChildScrollView(
        child: Consumer<MainProvider>(builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        mainProvider.clearController();
                        callNextReplacement(const LoginScreen(), context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(color: textBlue),
                            color: basewhite,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text('LOGOUT',
                            style: TextStyle(
                                fontSize: 13,
                                color: textBlue,
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
                            color: myBlue,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          'NOT NOW',
                          style: TextStyle(color: basewhite, fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
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
