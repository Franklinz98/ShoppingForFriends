import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:shopping_for_friends/models/product.dart';

class FriendList {
  final String name;
  final String uid;
  final int total;
  final UnmodifiableListView<Product> list;
  bool checked;

  FriendList({
    @required this.name,
    @required this.uid,
    @required this.total,
    @required this.list,
    @required this.checked,
  });
}
