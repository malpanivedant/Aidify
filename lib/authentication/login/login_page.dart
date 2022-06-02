import 'package:flutter/material.dart';
import 'package:help_on_needs/app_routes.dart';
import 'package:help_on_needs/app_theme.dart';
import 'package:help_on_needs/authentication/model/login_model.dart';
import 'package:help_on_needs/custom_widgets/button.dart';
import 'package:help_on_needs/custom_widgets/custom_text_input_widget.dart';

import '../../format_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(fontSize: 24.0),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: getLoginBody(),
    );
  }

  Widget getLoginBody() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ListView(
        children: [
          const Icon(
            Icons.account_circle,
            size: 150,
            color: Colors.redAccent,
          ),
          const SizedBox(height: 24),
          Row(
            children: const [
              Text(
                "Enter your email address",
                style: AppTheme.subHeading,
              ),
            ],
          ),
          getEmailWidget(),
          Row(
            children: const [
              Text(
                "Enter your password",
                style: AppTheme.subHeading,
              ),
            ],
          ),
          getPasswordWidget(),
          const SizedBox(height: 10),
          CustomButton(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 44),
            style: AppTheme.subHeading.copyWith(color: Colors.white),
            title: "Login",
            ontap: () {
              getLoginProvider().userType = UserType.ngo;
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(height: 30),
          InkWell(
            onTap: () {},
            child: Text(
              "Forgot password?",
              style: AppTheme.body.copyWith(color: Colors.blue),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 9),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.registerPage);
            },
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: AppTheme.body
                    .copyWith(color: Colors.black87, fontFamily: 'kanit'),
                children: [
                  const TextSpan(text: "Not a user? "),
                  TextSpan(
                    text: "Register here",
                    style: AppTheme.body
                        .copyWith(color: Colors.blue, fontFamily: 'kanit'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getEmailWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: CustomTextInputWidget(
        suffixIcon: const Icon(Icons.account_box_outlined),
        errorLabel: "Email Name",
        errorText: "Invalid Name",
        backgroundColor: const Color(0xFFe3e3e3),
        valid: true,
        textInputFormatter: FormatHelper.getInputFormatter(),
        textEditingController: emailController,
        placeHolder: "xyz@publicissapient.com",
        padding: EdgeInsets.zero,
        onChanged: (text) {},
      ),
    );
  }

  Widget getPasswordWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: CustomTextInputWidget(
        suffixIcon: const Icon(Icons.vpn_key),
        errorLabel: "Email Name",
        errorText: "Invalid Name",
        backgroundColor: const Color(0xFFe3e3e3),
        valid: true,
        textInputFormatter: FormatHelper.getInputFormatter(),
        textEditingController: passwordController,
        placeHolder: "XXXXXXXXXXXX",
        padding: EdgeInsets.zero,
        onChanged: (text) {},
      ),
    );
  }
}
