import 'package:arm_chat/exceptions/api_failure_exception.dart';
import 'package:arm_chat/services/push_notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String senderId;
  String message;
  DateTime date;
  Firestore _fs;
  CollectionReference messages;

  ChatModel.fire(Firestore fs) {
    _fs = fs;
    messages = _fs.collection('messages');
  }

  ChatModel({
    this.senderId,
    this.message,
    this.date,
  });

  addChat(String id, String message) {
    print('in here');
    return messages
        .add({'senderId': id, 'message': message, 'date': DateTime.now()}).then(
            (value) async {
      await PushNotification().sendMessage(id, message);
    }).catchError((error) => throw ApiFailureException(error.message));
  }

  Stream<QuerySnapshot> availableChats() {
    return _fs.collection('messages').snapshots();
  }
}
