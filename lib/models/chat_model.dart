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
    return messages.add({
      'senderId': id, // John Doe
      'message': message, // Stokes and Sons
      'date': DateTime.now() // 42
    }).then((value) async {
      await PushNotification().sendMessage(id, message);
    }).catchError((error) => throw ApiFailureException(error.message));
  }

  Stream<QuerySnapshot> availableChats() {
    return _fs.collection('messages').snapshots();
  }

  static List<ChatModel> list = [
    ChatModel(
      senderId: "1",
      message: "Hi Marti! do you have already reports?",
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    ChatModel(
      senderId: "1",
      message: "Sure we can talk tomorrow",
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    ChatModel(
      senderId: "1",
      message: "Hi Marti",
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    ChatModel(
      senderId: "2",
      message: "I'd like to discuss about reports for kate",
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    ChatModel(
      senderId: "2",
      message: "Are you available tomorrow at 3PM?",
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    ChatModel(
      senderId: "2",
      message: "Hi jonathan",
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];
}
