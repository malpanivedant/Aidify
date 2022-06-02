import 'package:flutter/material.dart';
import 'package:help_on_needs/app_theme.dart';
import 'package:help_on_needs/authentication/model/login_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile Page",
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
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 24),
            Text(
              getLoginProvider().getUserType() == UserType.ngo
                  ? "Hello NGO"
                  : "Hello Volunteer",
              style: AppTheme.heading,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
