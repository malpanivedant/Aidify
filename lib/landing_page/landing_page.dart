import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:help_on_needs/app_routes.dart';
import 'package:help_on_needs/app_theme.dart';
import 'package:help_on_needs/authentication/model/login_model.dart';
import 'package:help_on_needs/bloc/bloc_builder.dart';
import 'package:help_on_needs/landing_page/api_call/landing_page_bloc.dart';
import 'package:help_on_needs/landing_page/widgets/chip_button.dart';
import 'package:help_on_needs/landing_page/widgets/drawer_header.dart';
import 'package:help_on_needs/landing_page/widgets/playlist_card.dart';

import '../location_manager.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final LandingPageBloc _bloc = LandingPageBloc();
  int index = 0;
  Position? _position;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _bloc.getScreenData(0);
      _initLocation();
    });
    super.initState();
  }

  void _initLocation() async {
    _position = await LocationManager.shared.getCurrentPosition(context);
    debugPrint(_position?.latitude.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: DrawerMenu(),
      ),
      appBar: AppBar(
        title: const Text(
          "Help on Needs",
          style: TextStyle(fontSize: 24.0),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (getLoginProvider().getUserType() == UserType.guest) {
                Navigator.pushNamed(context, AppRoutes.loginPage);
              } else {
                Navigator.pushNamed(context, AppRoutes.profilePage);
              }
            },
            icon: const Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
      body: getScreen(),
    );
  }

  Widget getScreen() {
    return Column(
      children: [
        getChipList(),
        BlocBuilder(
          bloc: _bloc,
          builder: () {
            switch (_bloc.state.state) {
              case LandingPageState.inital:
                return const SizedBox();
              case LandingPageState.loading:
                return getLoadingWidget();
              case LandingPageState.success:
                return getPlayListScreen();
              case LandingPageState.failure:
                return errorScreen();
              case LandingPageState.empty:
                return emptyScreen();
            }
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget getLoadingWidget() {
    return const Padding(
      padding: EdgeInsets.only(top: 250),
      child: CircularProgressIndicator(),
    );
  }

  Widget getChipList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: CustomChipButton(
              isSelected: (index == 0),
              padding: const EdgeInsets.all(8),
              title: "Immediate attention",
              onPressed: () {
                setState(() {
                  index = 0;
                  _bloc.getScreenData(0);
                });
              },
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: CustomChipButton(
              isSelected: (index == 1),
              padding: const EdgeInsets.all(8),
              title: "Calamity nearby",
              onPressed: () {
                setState(() {
                  index = 1;
                  _bloc.getScreenData(1);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget emptyScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 200),
        Image.asset(
          "assets/images/happy.png",
          height: 150,
          width: 150,
        ),
        const SizedBox(height: 20),
        const Text("It is a happy day today", style: AppTheme.heading),
      ],
    );
  }

  Widget errorScreen() {
    return Padding(
      padding: const EdgeInsets.only(top: 200),
      child: Center(
        child: Image.asset(
          "assets/images/error.png",
          height: 150,
          width: 150,
        ),
      ),
    );
  }

  Widget getPlayListScreen() {
    return PlayListCard(
      disasterList: _bloc.state.disasterList!.disasterList!,
    );
  }
}
