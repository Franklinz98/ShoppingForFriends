import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_for_friends/backend/chat.dart';
import 'package:shopping_for_friends/models/chatroom.dart';
import 'package:shopping_for_friends/models/user_model.dart';
import 'package:shopping_for_friends/screens/chat.dart';
import 'package:shopping_for_friends/widgets/components/chat_preview.dart';

class ChatList extends StatefulWidget {
  final User user;

  ChatList({Key key, @required this.user}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  Future<List<ChatRoom>> futureChatList;
  StreamSubscription<QuerySnapshot> chatListener;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatListener = listenChats(widget.user.uid).listen((event) {
      setState(() {
        futureChatList = getChatRoompreview(widget.user.uid);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChatRoom>>(
      future: futureChatList,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data.isEmpty) {
              return Center(
                child: Text(
                  "No hay chats",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              List<ChatRoom> _validChats = [];
              snapshot.data.forEach((chat) {
                if (chat.lastMessage != null) {
                  _validChats.add(chat);
                }
              });
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                itemBuilder: (_, index) {
                  ChatRoom chatRoom = _validChats[index];
                  String _name = "";
                  chatRoom.names.forEach((nameC) {
                    if (nameC != _name) {
                      _name = nameC;
                    }
                  });
                  return ChatPreviewTile(
                      name: _name,
                      message: chatRoom.lastMessage,
                      onTap: () {
                        var future = Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Chat(
                              user: widget.user,
                              friendName: _name,
                              chatRoomId: chatRoom.key,
                            ),
                          ),
                        );
                        chatListener.pause(future);
                      });
                },
                itemCount: _validChats.length,
              );
            }
          } else {
            return Center(
              child: Text("error"),
            );
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    chatListener.cancel();
  }
}
