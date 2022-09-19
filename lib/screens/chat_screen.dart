import 'package:arm_chat/models/chat_model.dart';
import 'package:arm_chat/screens/auth_screen.dart';
import 'package:arm_chat/services/auth_service.dart';
import 'package:arm_chat/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatModel _chatModel;
  FirebaseUser _user;
  TextEditingController _chatController;
  ScrollController _scrollController;

  @override
  initState() {
    _chatModel = ChatModel.fire(Firestore.instance);
    Future.microtask(() async {
      var user =
          await context.read<AuthenticationService>().getCurrentUserAsync();
      setState(() {
        _user = user;
      });
    });
    _chatController = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  dispose() {
    _chatController.dispose();
    super.dispose();
  }

  _onLogout() async {
    await context.read<AuthenticationService>().logoutAsync();
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
            body: Column(
              children: [
                Expanded(
                  child: ChatStream(
                    chatStreams: _chatModel.availableChats(),
                    currentUser: _user,
                    controller: _scrollController,
                  ),
                ),
                _buildInput(),
              ],
            ),
          );
  }

  Widget _buildInput() {
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _chatController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                hintText: "Type something...",
                hintStyle: TextStyle(
                  color: Colors.white30,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: () {
              print('chat is ${_chatController.text}');
              if (_chatController.text != null &&
                  _chatController.text.trim().isNotEmpty) {
                _chatModel.addChat(_user.email, _chatController.text);
                _chatController.clear();
                FocusManager.instance.primaryFocus.unfocus();
                _scrollController.animateTo(
                  0.0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class ChatStream extends StatelessWidget {
  final Stream<QuerySnapshot> chatStreams;
  final FirebaseUser currentUser;
  final ScrollController controller;
  ChatStream({
    this.chatStreams,
    this.currentUser,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: chatStreams,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
          }

          final messages = snapshot.data.documents;
          print(messages);
          print(messages);
          List<ChatModel> chats = [];
          for (var message
              in messages.where((m) => m.data['message'] != null)) {
            final messageText = message.data['message'];
            final messageSender = message.data['senderId'];
            final date = message.data['date'].toDate();

            final ChatModel chatModel = ChatModel(
              message: messageText,
              senderId: messageSender,
              date: date,
            );
            chats.add(chatModel);
          }
          chats.sort((a, b) => b.date.compareTo(a.date));
          return ListView.builder(
            controller: controller,
            padding: kAppPadding.copyWith(bottom: 0),
            physics: BouncingScrollPhysics(),
            itemCount: chats.length,
            reverse: true,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ChatDetail(
                chat: chats[index],
                isCurrentUser: chats[index].senderId == currentUser?.email,
              );
            },
          );
        });
  }
}

class ChatDetail extends StatelessWidget {
  final bool isCurrentUser;
  final ChatModel chat;
  const ChatDetail({
    this.isCurrentUser,
    this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 12,
            ),
            margin: EdgeInsets.symmetric(
              vertical: 6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: isCurrentUser
                  ? kAccentColor.withOpacity(0.9)
                  : kPrimaryColor.withOpacity(0.9),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isCurrentUser)
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      chat.senderId,
                      style: kDefaultFontStyle.copyWith(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                Text(
                  chat.message ?? '',
                  style: TextStyle(
                    color: isCurrentUser ? kPrimaryColor : Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: isCurrentUser
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Text(
                      '${chat.date.hour}:${chat.date.minute}',
                      style: kDefaultFontStyle.copyWith(
                        fontSize: 15,
                        color: isCurrentUser ? kPrimaryColor : Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
