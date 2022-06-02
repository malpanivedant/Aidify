import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:help_on_needs/app_routes.dart';
import 'package:help_on_needs/custom_widgets/button.dart';
import 'package:intl/intl.dart';
import 'package:help_on_needs/app_theme.dart';
import 'package:help_on_needs/landing_page/models/landing_page_model.dart';

class CardDisplay extends StatelessWidget {
  final DisasterList disasterDetail;
  const CardDisplay({Key? key, required this.disasterDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          width: 350,
          decoration: BoxDecoration(
              boxShadow: getBoxShadow(),
              borderRadius: BorderRadius.circular(12)),
          // color: Colors.cyan[50],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: getChildren(context),
          ),
        ),
        if (disasterDetail.severity?.toUpperCase() == "HIGH")
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 25,
              width: 25,
              color: Colors.red,
              child: const Icon(Icons.star_outlined, color: Colors.white),
            ),
          )
      ],
    );
  }

  List<Widget> getChildren(BuildContext context) {
    List<Widget> children = [];
    children.add(getTitle());
    children.add(const SizedBox(height: 20));
    children.add(getRow());
    children.add(const SizedBox(height: 20));
    children.add(getLocation());
    children.add(const SizedBox(height: 20));
    children.add(CustomButton(
      title: "Help now",
      ontap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.disasterDetailPage,
          arguments: disasterDetail.title,
        );
      },
    ));

    return children;
  }

  Widget getTitle() {
    return Text(
      disasterDetail.title ?? "Natural Calamity",
      style: AppTheme.heading,
    );
  }

  Widget getRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 100,
          width: 100,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.redAccent, width: 1.5),
            borderRadius: BorderRadius.circular(15),
            boxShadow: getBoxShadow(),
          ),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: disasterDetail.imageUrl ?? '',
            placeholder: (context, url) => Image.asset(
              "assets/images/natural-disasters.png",
              fit: BoxFit.cover,
            ),
            errorWidget: (context, url, error) => Image.asset(
              "assets/images/natural-disasters.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 30),
        const SizedBox(
          height: 100,
          child: VerticalDivider(
            thickness: 1,
            color: Colors.black45,
          ),
        ),
        const SizedBox(width: 30),
        getDetails(),
      ],
    );
  }

  Widget getDetails() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getContent("Category : ", (disasterDetail.type ?? 'disaster')),
          const SizedBox(height: 8),
          getContent("Date : ", getDateFormat(disasterDetail.eventStartDate)),
          const SizedBox(height: 8),
          getContent("Services Needed : ", getHelpString()),
        ],
      ),
    );
  }

  Widget getContent(String title, String discription) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              AppTheme.body.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          discription,
          style: AppTheme.body.copyWith(fontSize: 12),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String getDateFormat(String? date) {
    DateTime disasterDate = DateTime.tryParse(date ?? '') ?? DateTime.now();
    DateFormat dateFormat = DateFormat('dd MMM yy');
    return dateFormat.format(disasterDate);
  }

  Widget getLocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 20,
          color: Colors.black,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            getLocationText(),
            style: AppTheme.subHeading,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  String getLocationText() {
    String location = (disasterDetail.city ?? '') +
        ', ' +
        (disasterDetail.state ?? '') +
        ', ' +
        (disasterDetail.country ?? '');
    return location;
  }

  List<BoxShadow> getBoxShadow() {
    List<BoxShadow> list = [
      BoxShadow(
        color: Colors.red.shade100,
        offset: const Offset(
          1.0,
          1.0,
        ),
        blurRadius: 5.0,
        spreadRadius: 1.0,
      ), //BoxShadow
      const BoxShadow(
        color: Colors.white,
        offset: Offset(0.0, 0.0),
        blurRadius: 0.0,
        spreadRadius: 0.0,
      ), //BoxShadow
    ];
    return list;
  }

  String getHelpString() {
    List<String> list = disasterDetail.requires ?? [];
    String requires = '';
    for (int index = 0; index < list.length; index++) {
      if (index != list.length - 1) {
        requires = requires + list[index] + ', ';
      } else {
        requires = requires + list[index];
      }
    }
    if (requires.isEmpty) {
      requires = 'Monetory';
    }
    return requires;
  }
}
