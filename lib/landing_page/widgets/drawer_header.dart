import 'package:flutter/material.dart';
import 'package:help_on_needs/app_theme.dart';
import 'package:help_on_needs/authentication/model/login_model.dart';

import '../../app_routes.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        InkWell(
          onTap: () {
            if (getLoginProvider().getUserType() == UserType.guest) {
              Navigator.pushNamed(context, AppRoutes.loginPage);
            } else {
              Navigator.pushNamed(context, AppRoutes.profilePage);
            }
          },
          child: const ListTile(
            title: Text(
              'Profile',
              style: AppTheme.subHeading,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const ListTile(
            title: Text(
              'Donate',
              style: AppTheme.subHeading,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        if (getLoginProvider().userType == UserType.ngo)
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const ListTile(
              title: Text(
                'Request for Help',
                style: AppTheme.subHeading,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        if (getLoginProvider().userType != UserType.guest)
          InkWell(
            onTap: () {
              getLoginProvider().userType = UserType.guest;
              Navigator.of(context).pop();
            },
            child: const ListTile(
              title: Text(
                'Logout',
                style: AppTheme.subHeading,
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
