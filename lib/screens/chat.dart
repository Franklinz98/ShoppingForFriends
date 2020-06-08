import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_for_friends/backend/chat.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/constants/enums.dart';
import 'package:shopping_for_friends/models/message.dart';
import 'package:shopping_for_friends/models/user_model.dart';
import 'package:shopping_for_friends/widgets/components/input.dart';
import 'package:shopping_for_friends/widgets/components/message_item.dart';

class Chat extends StatefulWidget {
  final User user;
  final String chatRoomId;

  Chat({Key key, @required this.user, @required this.chatRoomId})
      : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charade,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.cornflower_blue,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Expanded(
                    child: Text(
                      "Amigo 1",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: AppColors.tuna,
                child: StreamBuilder<QuerySnapshot>(
                    stream: getConversation(widget.chatRoomId),
                    builder: (context, snapshot) {
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return new Text('Loading...');
                        default:
                          return ListView(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            children: snapshot.data.documents
                                .map((DocumentSnapshot messageMap) {
                              Message message = Message.fromMap(
                                messageMap.data,
                              );
                              return MessageTile(
                                type: widget.user.uid == message.uid
                                    ? MessageType.local
                                    : MessageType.remote,
                                message: message,
                              );
                            }).toList().reversed.toList(),
                            reverse: true,
                          );
                      }
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Input(
                      validator: null,
                      controller: messageController,
                      hintText: "Escribe un mensaje",
                      inputType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  FloatingActionButton(
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    heroTag: "Send Message",
                    elevation: 0,
                    mini: true,
                    onPressed: () => _sendMessage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _sendMessage() {
    Message message = Message(
      uid: widget.user.uid,
      name: widget.user.name,
      message: messageController.text,
      millis: DateTime.now().millisecondsSinceEpoch,
    );
    sendMessage(widget.chatRoomId, message)
        .then((value) => messageController.clear());
  }
}
