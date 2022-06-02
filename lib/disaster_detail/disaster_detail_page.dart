import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:help_on_needs/app_theme.dart';
import 'package:help_on_needs/bloc/bloc_builder.dart';
import 'package:help_on_needs/disaster_detail/api_call/details_page_bloc.dart';
import 'package:help_on_needs/disaster_detail/models/details_page_model.dart';
import 'package:help_on_needs/disaster_detail/widget/ngo_card.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DisasterDetailPage extends StatefulWidget {
  const DisasterDetailPage({Key? key}) : super(key: key);

  @override
  State<DisasterDetailPage> createState() => _DisasterDetailPageState();
}

class _DisasterDetailPageState extends State<DisasterDetailPage> {
  final DetailsPageBloc _bloc = DetailsPageBloc();
  String? argument;
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      argument = ModalRoute.of(context)?.settings.arguments as String?;
      _bloc.getScreenData(argument);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Disaster Details",
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
      body: getScreenData(),
    );
  }

  Widget getScreenData() {
    return BlocBuilder(
      bloc: _bloc,
      builder: () {
        switch (_bloc.state.state) {
          case DetailsPageState.loading:
            return const Center(child: CircularProgressIndicator());
          case DetailsPageState.inital:
            return const SizedBox();
          case DetailsPageState.success:
            return getSuccessWidget();
          case DetailsPageState.failure:
            return errorScreen();
        }
      },
    );
  }

  Widget errorScreen() {
    return Center(
      child: Image.asset(
        "assets/images/error.png",
        height: 150,
        width: 150,
      ),
    );
  }

  Widget getSuccessWidget() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: getChildrenWidget(),
    );
  }

  List<Widget> getChildrenWidget() {
    List<Widget> children = [];
    children.add(Text(
      _bloc.state.data!.name!,
      style: AppTheme.heading,
      textAlign: TextAlign.center,
    ));
    children.add(const SizedBox(height: 15));
    children.add(imageCard());
    children.add(const SizedBox(height: 12));
    children.add(Align(child: getLocation()));
    children.add(const SizedBox(height: 12));
    children.add(getDateRow());
    children.add(const SizedBox(height: 24));
    children.add(Text(
      _bloc.state.data!.description!,
      style: AppTheme.body,
    ));
    children.add(const SizedBox(height: 30));
    children.add(getGridView());

    children.add(const SizedBox(height: 30));
    children.add(Text(
      "Organisations on ground",
      style: AppTheme.heading.copyWith(fontSize: 20),
    ));
    children.add(const SizedBox(height: 16));

    for (Organization organization in _bloc.state.data!.organizations!) {
      children.add(NgoCard(organization: organization));

      children.add(const SizedBox(height: 16));
    }

    return children;
  }

  Widget getLocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.location_on_outlined,
            size: 20, color: Colors.redAccent),
        const SizedBox(width: 6),
        Text(
          _bloc.state.data!.location ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTheme.subHeading,
        ),
      ],
    );
  }

  Widget imageCard() {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.redAccent, width: 1),
        borderRadius: BorderRadius.circular(15),
        boxShadow: getBoxShadow(),
      ),
      child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: _bloc.state.data!.imageurl ?? '',
        placeholder: (context, url) => Image.asset(
          "assets/images/placeholder.jpeg",
          fit: BoxFit.fill,
        ),
        errorWidget: (context, url, error) => Image.asset(
          "assets/images/placeholder.jpeg",
          fit: BoxFit.fill,
        ),
      ),
    );
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

  Widget getDateRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.calendar_today, size: 16, color: Colors.redAccent),
        const SizedBox(width: 4),
        Text(getDateFormat(_bloc.state.data!.eventStartDate),
            style: AppTheme.body),
        const SizedBox(width: 8),
        const Icon(
          Icons.location_searching_rounded,
          color: Colors.redAccent,
          size: 16,
        ),
        const SizedBox(width: 4),
        InkWell(
          onTap: () async {
            await _launchMap(0.0, 0.0);
          },
          child: const Text("View Map", style: AppTheme.body),
        )
      ],
    );
  }

  Widget getGridView() {
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
                child: grid("People Affected",
                    _bloc.state.data!.peopleImpacted.toString() + '+')),
            const SizedBox(width: 4),
            Expanded(
                child:
                    grid("Financial Impact", _bloc.state.data!.financialLoss!)),
          ],
        ),
        const SizedBox(height: 4),
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
                child: grid("NGOs Volunteerered",
                    _bloc.state.data!.organizationCount.toString())),
            const SizedBox(width: 4),
            Expanded(child: grid("Services Needed", getHelpString())),
          ],
        ),
      ],
    );
  }

  Widget grid(String titleText, String response) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            titleText,
            style: AppTheme.body.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            response,
            style: AppTheme.body
                .copyWith(fontWeight: FontWeight.w200, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Future<void> _launchMap(double latitude, double longitude) async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    String appleUrl = "https://maps.apple.com/?q=$latitude,$longitude";
    String otherMapUrl = "geo://0,0?q=$latitude%2C$longitude";

    if (Platform.isIOS) {
      googleUrl = 'comgooglemaps://?center=$latitude,$longitude';
      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        await launch(appleUrl);
      }
    } else {
      if (await canLaunch(otherMapUrl)) {
        await launch(otherMapUrl);
      } else {
        await launch(googleUrl);
      }
    }
  }

  Future<void> openMapInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'key': 'value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  String getHelpString() {
    List<String> list = _bloc.state.data!.accepts ?? [];
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

  String getDateFormat(String? date) {
    DateTime disasterDate = DateTime.tryParse(date ?? '') ?? DateTime.now();
    DateFormat dateFormat = DateFormat('dd MMM yy');
    return dateFormat.format(disasterDate);
  }
}
