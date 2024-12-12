import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_machine_test/Constants/colors.dart';
import 'package:provider/provider.dart';

import '../Provider/main_provider.dart';
import '../Widgets/login_button.dart';
import '../Widgets/login_title_widget.dart';
import '../Widgets/textformfield_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: false);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double textSize = width > 700 ? 22 : width * 0.04;
    double textWidth = width > 700 ? 12 : width * 0.03;
    DateTime? lastPressed;
    return WillPopScope(
      onWillPop: () async {
        if (lastPressed == null ||
            DateTime.now().difference(lastPressed!) > Duration(seconds: 2)) {
          lastPressed = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
            ),
          );
          return false;
        }
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: basewhite,
        body: Center(
          child: Consumer<MainProvider>(
            builder: (context, value, child) {
              return Form(
                key: value.formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      loginTitleWidget(context),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      loginTextFormFieldWidget(
                        context,
                        value.userNameController,
                        'Username',
                        value.usernameError,
                        (value) {
                          if (value!.isEmpty) {
                            return 'Username cannot be empty';
                          }
                          return null;
                        },
                      ),
                      loginTextFormFieldWidget(
                        context,
                        value.passwordController,
                        'Password',
                        value.passwordError,
                        (values) {
                          if (values!.isEmpty) {
                            return 'Password cannot be empty';
                          } else if (values.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          mainProvider.login(context);
                        },
                        child: login_button(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
