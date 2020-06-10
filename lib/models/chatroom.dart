import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shopping_for_friends/models/message.dart';

class ChatRoom {
  String key;
  List<String> names;
  List<String> uids;
  Message lastMessage;

  ChatRoom(
      {@required this.key,
      @required this.names,
      @required this.uids,
      @required this.lastMessage});

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    Message _message;
    if (map['lastMessage'] != null) {
      _message = Message.fromMap(map['lastMessage']);
    }
    List<String> _users = [];
    map['users'].forEach((user) {
      _users.add(user);
    });
    List<String> _uids = [];
    map['uids'].forEach((uid) {
      _uids.add(uid);
    });
    return ChatRoom(
        key: map['chatRoomId'],
        names: _users,
        uids: _uids,
        lastMessage: _message);
  }
}
