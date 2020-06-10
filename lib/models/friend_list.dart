import 'dart:collection';
import 'dart:convert';
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
    this.checked,
  });

  factory FriendList.fromMap(Map<String, dynamic> map) {
    List<Product> _products = [];
    var sadg = map['list'];
    sadg.forEach((element) {
      print(element.runtimeType);
      _products.add(Product.fromMap(element));
    });
    return FriendList(
        name: map['name'],
        uid: map['uid'],
        total: map['total'],
        list: UnmodifiableListView<Product>(_products));
  }

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> _list = [];
    list.forEach((element) {
      _list.add(element.toMap());
    });
    return {
      'name': name,
      'uid': uid,
      'total': total,
      'list': _list,
    };
  }
}
