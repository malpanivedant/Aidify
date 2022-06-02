import 'package:flutter/material.dart';
import 'package:help_on_needs/app_routes.dart';
import 'package:help_on_needs/app_theme.dart';
import 'package:help_on_needs/authentication/model/login_model.dart';
import 'package:help_on_needs/bloc/bloc_builder.dart';
import 'package:help_on_needs/custom_widgets/button.dart';
import 'package:help_on_needs/custom_widgets/custom_text_input_widget.dart';
import 'package:help_on_needs/custom_widgets/radio_botton_controller.dart';
import 'package:help_on_needs/custom_widgets/radio_button.dart';

import '../../format_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController organisationController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final RadioButtonController radioButtonController = RadioButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(fontSize: 24.0),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).popUntil(
                (route) => route.settings.name == AppRoutes.landingPage);
          },
        ),
      ),
      body: getLoginBody(),
    );
  }

  Widget getLoginBody() {
    return ListView(
      padding: const EdgeInsets.all(24),
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
              "Enter your Name",
              style: AppTheme.subHeading,
            ),
          ],
        ),
        getNameWidget(),
        Row(
          children: const [
            Text(
              "Enter your mobile number",
              style: AppTheme.subHeading,
            ),
          ],
        ),
        getMobileWidget(),
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
        BlocBuilder(
          bloc: radioButtonController,
          builder: () {
            return CustomRadioButton(
              verticalPadding: 0,
              horizontalPadding: 0,
              label: "Register as NGO",
              circledRadio: true,
              isCenteredAlign: true,
              isTextFontRegular: true,
              isSelected: radioButtonController.state.isSelected,
              onClicked: () {
                radioButtonController.toggle();
              },
            );
          },
        ),
        BlocBuilder(
          bloc: radioButtonController,
          builder: () {
            return Column(
              children: [
                if (radioButtonController.state.isSelected)
                  const SizedBox(height: 20),
                if (radioButtonController.state.isSelected)
                  Row(
                    children: const [
                      Text(
                        "Enter your organisation address",
                        style: AppTheme.subHeading,
                      ),
                    ],
                  ),
                if (radioButtonController.state.isSelected)
                  getOrganisationWidget(),
                if (!radioButtonController.state.isSelected)
                  const SizedBox(height: 20),
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        CustomButton(
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 44),
          style: AppTheme.subHeading.copyWith(color: Colors.white),
          title: "Register",
          ontap: () {
            if (radioButtonController.state.isSelected) {
              getLoginProvider().userType = UserType.ngo;
            } else {
              getLoginProvider().userType = UserType.volunteer;
            }
            Navigator.popUntil(context,
                (route) => route.settings.name == AppRoutes.landingPage);
          },
        ),
      ],
    );
  }

  Widget getEmailWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: CustomTextInputWidget(
        suffixIcon: const Icon(Icons.account_box_outlined),
        errorLabel: "Enter your email",
        errorText: "Invalid email",
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

  Widget getNameWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: CustomTextInputWidget(
        suffixIcon: const Icon(Icons.person),
        backgroundColor: const Color(0xFFe3e3e3),
        valid: true,
        textInputFormatter: FormatHelper.getInputFormatter(),
        textEditingController: nameController,
        placeHolder: "John Oswald",
        padding: EdgeInsets.zero,
        onChanged: (text) {},
      ),
    );
  }

  Widget getMobileWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: CustomTextInputWidget(
        suffixIcon: const Icon(Icons.call),
        errorLabel: "Enter Mobile Number",
        errorText: "Invalid Number",
        backgroundColor: const Color(0xFFe3e3e3),
        valid: true,
        textInputFormatter: FormatHelper.getMobileNumberFormatter(),
        textEditingController: mobileController,
        placeHolder: "+919999999999",
        padding: EdgeInsets.zero,
        onChanged: (text) {},
      ),
    );
  }

  Widget getOrganisationWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: CustomTextInputWidget(
        suffixIcon: const Icon(Icons.groups_rounded),
        backgroundColor: const Color(0xFFe3e3e3),
        valid: true,
        textInputFormatter: FormatHelper.getInputFormatter(),
        textEditingController: organisationController,
        placeHolder: "Enter your NGO name",
        padding: EdgeInsets.zero,
        onChanged: (text) {},
      ),
    );
  }
}
