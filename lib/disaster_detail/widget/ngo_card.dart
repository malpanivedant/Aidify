import 'package:flutter/material.dart';
import 'package:help_on_needs/app_routes.dart';
import 'package:help_on_needs/app_theme.dart';
import 'package:help_on_needs/authentication/model/login_model.dart';
import 'package:help_on_needs/bloc/bloc_builder.dart';
import 'package:help_on_needs/custom_widgets/custom_alert_dialogbox.dart';
import 'package:help_on_needs/disaster_detail/models/details_page_model.dart';
import 'package:help_on_needs/disaster_detail/widget/ngo_card_state_controller.dart';
import 'package:help_on_needs/landing_page/widgets/chip_button.dart';

class NgoCard extends StatefulWidget {
  final Organization organization;
  const NgoCard({Key? key, required this.organization}) : super(key: key);

  @override
  State<NgoCard> createState() => _NgoCardState();
}

class _NgoCardState extends State<NgoCard> {
  final NgoCardController _controller = NgoCardController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(20),
      ),
      child: BlocBuilder(
        bloc: _controller,
        builder: () {
          if (_controller.state.isExpanded) {
            return getExpandedWidget();
          } else {
            return getCollapsedWidget();
          }
        },
      ),
    );
  }

  Widget getExpandedWidget() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: getExpandedServiceList());
  }

  List<Widget> getExpandedServiceList() {
    List<Widget> serviceList = [];
    serviceList.add(getListTile());
    serviceList.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Text(
          widget.organization.about ?? '',
          style: AppTheme.body,
        ),
      ),
    );
    serviceList.add(const SizedBox(height: 8));
    serviceList.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Text(
          "Details",
          style: AppTheme.body
              .copyWith(fontWeight: FontWeight.w500, fontSize: 16.0),
        ),
      ),
    );

    serviceList.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: getDetailsRow(
            "FOUNDER", "Founded by " + (widget.organization.founder ?? '')),
      ),
    );
    serviceList.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: getDetailsRow(
            "FOUNDED", "Founded on " + (widget.organization.founded ?? '2017')),
      ),
    );
    serviceList.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: getDetailsRow(
            "VOLUNTEERS",
            (widget.organization.volunteerCount.toString()) +
                " volunteers support us"),
      ),
    );
    serviceList.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: getDetailsRow(
            "CALL", widget.organization.contact ?? '+919999999999'),
      ),
    );

    serviceList.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: getDetailsRow(
            "WEBSITE", widget.organization.website ?? 'helponneeds.com'),
      ),
    );
    serviceList.add(const SizedBox(height: 8));
    serviceList.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Text(
          "Service Accepts",
          style: AppTheme.body
              .copyWith(fontWeight: FontWeight.w500, fontSize: 16.0),
        ),
      ),
    );

    for (String service in widget.organization.accepts!) {
      serviceList.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: getServicesRow(service),
        ),
      );
    }

    serviceList.add(const SizedBox(height: 16));
    serviceList.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: CustomChipButton(
        title: "Help Now",
        padding: const EdgeInsets.all(12),
        onPressed: () async {
          if (getLoginProvider().userType == UserType.guest) {
            await const CustomAlertDialog(
              errorTitle: "Not Loggedin",
              errorMessage: "Please Login before commiting to help",
              buttonTitle: "Login Now",
            ).showAlertDialog(context);
            Navigator.pushNamed(context, AppRoutes.loginPage);
          } else {
            Navigator.pushNamed(context, AppRoutes.formPage);
          }
        },
      ),
    ));
    serviceList.add(const SizedBox(height: 16));

    return serviceList;
  }

  Widget getCollapsedWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: getCollaspedServiceList(),
    );
  }

  List<Widget> getCollaspedServiceList() {
    List<Widget> serviceList = [];
    serviceList.add(getListTile());

    for (String service in widget.organization.accepts!) {
      serviceList.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: getServicesRow(service),
        ),
      );
    }

    serviceList.add(const SizedBox(height: 16));
    serviceList.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: CustomChipButton(
        title: "Help Now",
        padding: const EdgeInsets.all(12),
        onPressed: () async {
          if (getLoginProvider().userType == UserType.guest) {
            await const CustomAlertDialog(
              errorTitle: "Not Loggedin",
              errorMessage: "Please Login before commiting to help",
              buttonTitle: "Login Now",
            ).showAlertDialog(context);
            Navigator.pushNamed(context, AppRoutes.loginPage);
          } else {
            Navigator.pushNamed(context, AppRoutes.formPage);
          }
        },
      ),
    ));
    serviceList.add(const SizedBox(height: 16));

    return serviceList;
  }

  Widget getListTile() {
    return ListTile(
      title: Text(
        widget.organization.name!,
        style: AppTheme.heading.copyWith(fontSize: 20),
      ),
      subtitle: getTag(),
      trailing: InkWell(
        borderRadius: BorderRadius.circular(60),
        child: Icon(
          _controller.state.isExpanded
              ? Icons.keyboard_arrow_up
              : Icons.keyboard_arrow_down,
          color: Colors.redAccent,
          size: 36,
        ),
        onTap: () {
          _controller.toggle();
        },
      ),
    );
  }

  Widget? getTag() {
    if (widget.organization.verified ?? false) {
      return Row(
        children: [
          CustomChipButton(
            isSelected: true,
            padding: const EdgeInsets.all(4),
            titleWidget: Text(
              'verified',
              style: AppTheme.body.copyWith(fontSize: 8, color: Colors.white),
            ),
          ),
          const Spacer()
        ],
      );
    }
  }

  Widget getServicesRow(String service) {
    return Row(
      children: [
        Icon(
          getAppropriateIcon(service.toUpperCase()),
          size: 20,
        ),
        const SizedBox(width: 8),
        Expanded(
            child: Text(
          service,
          style: AppTheme.body,
        ))
      ],
    );
  }

  Widget getDetailsRow(String service, String title) {
    return Row(
      children: [
        Icon(
          getAppropriateIcon(service.toUpperCase()),
          size: 20,
        ),
        const SizedBox(width: 8),
        Expanded(
            child: Text(
          title,
          style: AppTheme.body,
        ))
      ],
    );
  }

  IconData getAppropriateIcon(String service) {
    switch (service) {
      case "MONEY":
        return Icons.monetization_on_outlined;
      case "FOOD":
        return Icons.food_bank_outlined;
      case "HUMAN-AID":
        return Icons.person;
      case "WATER":
        return Icons.water_damage_outlined;
      case "MEDICINES":
        return Icons.medication_outlined;
      case "ACCOMMODATION":
        return Icons.night_shelter_outlined;
      case "VOLUNTEERS":
        return Icons.group_add_outlined;
      case "CALL":
        return Icons.phone;
      case "FOUNDED":
        return Icons.foundation_rounded;
      case "FOUNDER":
        return Icons.person;
      case "WEBSITE":
        return Icons.web;
      default:
        return Icons.add_circle_outline_outlined;
    }
  }
}
