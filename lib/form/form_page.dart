import 'package:flutter/material.dart';
import 'package:help_on_needs/app_routes.dart';
import 'package:help_on_needs/app_theme.dart';
import 'package:help_on_needs/bloc/bloc_builder.dart';
import 'package:help_on_needs/custom_widgets/button.dart';
import 'package:help_on_needs/custom_widgets/custom_alert_dialogbox.dart';
import 'package:help_on_needs/custom_widgets/custom_text_input_widget.dart';
import 'package:help_on_needs/custom_widgets/radio_botton_controller.dart';
import 'package:help_on_needs/custom_widgets/radio_button.dart';

import '../../format_helper.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController expectedTimeController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController pickupController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController additionalComentController = TextEditingController();
  final RadioButtonController radioButtonController = RadioButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Commit to help",
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
        DrawerHeader(
          child: Container(
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 3)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/volunteer.png",
                  fit: BoxFit.scaleDown,
                ),
              )),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: const [
            Expanded(
              child: Text(
                "Please mention service type",
                style: AppTheme.subHeading,
              ),
            ),
          ],
        ),
        getServiceNameWidget(),
        Row(
          children: const [
            Text(
              "Please enter discription",
              style: AppTheme.subHeading,
            ),
          ],
        ),
        getDescriptionWidget(),
        Row(
          children: const [
            Expanded(
              child: Text(
                "Please Mention by when will be providing",
                style: AppTheme.subHeading,
              ),
            ),
          ],
        ),
        getExpectedDateWidget(),
        Row(
          children: const [
            Text(
              "Additional Comments",
              style: AppTheme.subHeading,
            ),
          ],
        ),
        getAdditionalCommmentsWidget(),
        BlocBuilder(
          bloc: radioButtonController,
          builder: () {
            return CustomRadioButton(
              verticalPadding: 0,
              horizontalPadding: 0,
              label: "Requests pickup?",
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
                        "Enter pickup address",
                        style: AppTheme.subHeading,
                      ),
                    ],
                  ),
                if (radioButtonController.state.isSelected) getPickupWidget(),
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
          title: "Commit",
          ontap: () async {
            await const CustomAlertDialog(
                    errorTitle: "Thank you for your support",
                    errorMessage:
                        "We with get in touch with you very soon. Keep Helping 😄",
                    buttonTitle: "Ok")
                .showAlertDialog(context);
            Navigator.popUntil(context,
                (route) => route.settings.name == AppRoutes.landingPage);
          },
        ),
      ],
    );
  }

  Widget getExpectedDateWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: CustomTextInputWidget(
        suffixIcon: const Icon(Icons.date_range),
        backgroundColor: const Color(0xFFe3e3e3),
        valid: true,
        textInputFormatter: FormatHelper.getInputFormatter(),
        textEditingController: expectedTimeController,
        placeHolder: "Eg: can provide by today",
        padding: EdgeInsets.zero,
        onChanged: (text) {},
      ),
    );
  }

  Widget getAdditionalCommmentsWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: CustomTextInputWidget(
        suffixIcon: const Icon(Icons.integration_instructions_outlined),
        backgroundColor: const Color(0xFFe3e3e3),
        valid: true,
        textInputFormatter: FormatHelper.getInputFormatter(),
        textEditingController: additionalComentController,
        placeHolder: "Eg: Can also provide transport vehicle for 2 hours",
        padding: EdgeInsets.zero,
        onChanged: (text) {},
      ),
    );
  }

  Widget getServiceNameWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: CustomTextInputWidget(
        suffixIcon: const Icon(Icons.home_repair_service_rounded),
        backgroundColor: const Color(0xFFe3e3e3),
        valid: true,
        textInputFormatter: FormatHelper.getInputFormatter(),
        textEditingController: serviceNameController,
        placeHolder: "Money, food, shelter, etc",
        padding: EdgeInsets.zero,
        onChanged: (text) {},
      ),
    );
  }

  Widget getDescriptionWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: CustomTextInputWidget(
        suffixIcon: const Icon(Icons.description),
        backgroundColor: const Color(0xFFe3e3e3),
        valid: true,
        textInputFormatter: FormatHelper.getInputFormatter(),
        textEditingController: descriptionController,
        placeHolder: "Eg: Will provide 2 Kg of rice",
        padding: EdgeInsets.zero,
        onChanged: (text) {},
      ),
    );
  }

  Widget getPickupWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: CustomTextInputWidget(
        suffixIcon: const Icon(Icons.location_on_outlined),
        backgroundColor: const Color(0xFFe3e3e3),
        valid: true,
        textInputFormatter: FormatHelper.getInputFormatter(),
        textEditingController: pickupController,
        placeHolder: "PickUp",
        padding: EdgeInsets.zero,
        onChanged: (text) {},
      ),
    );
  }
}
