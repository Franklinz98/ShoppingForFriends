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
}
