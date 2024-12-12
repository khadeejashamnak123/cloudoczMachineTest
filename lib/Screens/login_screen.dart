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
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    DateTime? lastPressed;
    return WillPopScope(
      onWillPop: () async {
        if (lastPressed == null ||
            DateTime.now().difference(lastPressed!) > const Duration(seconds: 2)) {
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
          child: LoginFormWidget(formKey: formKey),
        ),
      ),
    );
  }
}


class LoginFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const LoginFormWidget({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context);

    double height = MediaQuery.of(context).size.height;

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            loginTitleWidget(context),
            SizedBox(height: height * 0.05),
            loginTextFormFieldWidget(
              context,
              mainProvider.userNameController,
              'Username',
              mainProvider.usernameError,
                  (value) {
                if (value!.isEmpty) {
                  return 'Username cannot be empty';
                }
                return null;
              },
            ),
            loginTextFormFieldWidget(
              context,
              mainProvider.passwordController,
              'Password',
              mainProvider.passwordError,
                  (value) {
                if (value!.isEmpty) {
                  return 'Password cannot be empty';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                if (formKey.currentState?.validate() ?? false) {
                  mainProvider.login(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid credentials! Please try again.'),
                    ),
                  );
                }
              },
              child: login_button(context),
            ),
          ],
        ),
      ),
    );
  }
}
