import 'package:flutter/foundation.dart';

class Message {
  final String uid;
  final String name;
  final String message;
  final int millis;

  Message({
    @required this.uid,
    @required this.name,
    @required this.message,
    @required this.millis,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      uid: map['sendBy'],
      name: map['name'],
      message: map['message'],
      millis: map['datetime'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sendBy': uid,
      'name': name,
      'message': message,
      'datetime': millis,
    };
  }
}
