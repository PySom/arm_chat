import 'package:arm_chat/screens/auth_screen.dart';
import 'package:arm_chat/services/auth_service.dart';
import 'package:arm_chat/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  _onLogout() async {
    await context.read<AuthenticationService>().logoutAsync();
    Navigator.of(context).pushNamed(AuthScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseUser user = context.watch<FirebaseUser>();
    return user == null
        ? AuthScreen()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: Text('Group Chat'),
              actions: [
                PopupMenuButton<String>(
                  onSelected: (_) async => _onLogout(),
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: 'logout',
                        child: Text(
                          'Logout',
                          style: kDefaultFontStyle,
                        ),
                      )
                    ];
                  },
                ),
              ],
            ),
            body: Padding(
              padding: kAppPadding,
              child: Container(
                child: Text('Chat screen'),
              ),
            ),
          );
  }
}
