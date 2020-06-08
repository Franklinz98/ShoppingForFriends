import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/constants/enums.dart';
import 'package:shopping_for_friends/models/message.dart';
import 'package:shopping_for_friends/models/user_model.dart';
import 'package:shopping_for_friends/widgets/components/input.dart';
import 'package:shopping_for_friends/widgets/components/message_item.dart';

class Chat extends StatefulWidget {
  final User user;

  Chat({Key key, @required this.user}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Message> messages;
  TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    messages = [];
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
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  itemBuilder: (BuildContext context, int index) {
                    Message message = messages[index];
                    return MessageTile(
                      type: widget.user.uid == message.uid
                          ? MessageType.local
                          : MessageType.remote,
                      message: message,
                    );
                  },
                  itemCount: messages.length,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Input(
                      validator: null,
                      controller: messageController,
                      hintText: "Escribe un mensaje",
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  FloatingActionButton(
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    heroTag: "Send Message",
                    elevation: 0,
                    mini: true,
                    onPressed: () {
                      setState(() {
                        if (Random().nextInt(2) % 2 == 0) {
                          messages.add(
                            Message(
                              uid: widget.user.uid,
                              name: widget.user.name,
                              message: messageController.text,
                              millis: DateTime.now().millisecondsSinceEpoch,
                            ),
                          );
                        } else {
                          messages.add(
                            Message(
                              uid: "other",
                              name: "Amigo",
                              message: messageController.text,
                              millis: DateTime.now().millisecondsSinceEpoch,
                            ),
                          );
                        }
                        messageController.clear();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
