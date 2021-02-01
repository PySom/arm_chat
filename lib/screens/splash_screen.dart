import 'package:arm_chat/screens/auth_screen.dart';
import 'package:arm_chat/screens/chat_screen.dart';
import 'package:arm_chat/services/auth_service.dart';
import 'package:arm_chat/services/push_notification_service.dart';
import 'package:arm_chat/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _prepareAppStates();
  }

  _prepareAppStates() async {
    //perform start up logic
    PushNotification().initialize();
    final FirebaseUser user =
        await context.read<AuthenticationService>().getCurrentUserAsync();
    if (user == null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          AuthScreen.id, (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
          ChatScreen.id, (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Text('Splash screen'),
      ),
    );
  }
}
