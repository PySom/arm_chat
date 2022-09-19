import 'dart:convert';
import 'dart:io';
import 'package:arm_chat/utils/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class PushNotification {
  final FirebaseMessaging _fbm = FirebaseMessaging();

  void initialize() {
    _fbm.subscribeToTopic('all');
    if (Platform.isIOS) {
      //require IOS permission
      _fbm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fbm.configure(
        //called when app is in foreground and notification comes
        onMessage: (Map<String, dynamic> message) async {
          print('onMessage: $message');
        },
        //called when app has been closed completely and it's opened from notification drawer
        onLaunch: (Map<String, dynamic> message) async {},
        //called when app is in the background and it's opened from notification drawer
        onResume: (Map<String, dynamic> message) async {});
  }

  Future<void> sendMessage(String title, String body) async {
    try {
      await http.post(
        'https://fcm.googleapis.com/fcm/send',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$kServerKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            },
            'to': '/topics/all',
          },
        ),
      );

    } catch (error) {
      print(error.message);
    }
  }
}
