import 'package:flutter/foundation.dart';
import 'package:shopping_for_friends/models/message.dart';

class ChatRoom {
  final String key;
  final String uidA;
  final String uidB;

  ChatRoom({@required this.key, @required this.uidA, @required this.uidB});

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      key: map['chatRoomId'],
      uidA: map['users'][0],
      uidB: map['users'][1],
    );
  }
}
