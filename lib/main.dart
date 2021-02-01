import 'package:arm_chat/providers/provider_list.dart';
import 'package:arm_chat/screens/auth_screen.dart';
import 'package:arm_chat/screens/splash_screen.dart';
import 'package:arm_chat/utils/app_routes.dart';
import 'package:arm_chat/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CrowdExpress',
        theme: myThemeData(context),
        initialRoute: SplashScreen.id,
        routes: appRoutes,
      ),
    );
  }
}
