import 'package:flutter/material.dart';
import 'package:help_on_needs/app_routes.dart';
import 'package:help_on_needs/authentication/model/login_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) {
          return LoginModel();
        })
      ],
      child: MaterialApp(
        navigatorKey: GlobalKeys.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'kanit',
          splashColor: Colors.red.shade100,
          hoverColor: Colors.red.shade100,
          highlightColor: Colors.red.shade100,
        ),
        routes: AppRoutes.getRoutes(),
        initialRoute: AppRoutes.landingPage,
      ),
    );
  }
}
