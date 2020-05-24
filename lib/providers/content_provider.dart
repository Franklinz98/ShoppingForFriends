import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:shopping_for_friends/models/product.dart';

class ContentProvider extends ChangeNotifier {
  List<Product> _myList = [];
  List<UnmodifiableListView> _friendsLists = [];
  List<String> _friendsList = [];

  UnmodifiableListView<Product> get myList => UnmodifiableListView(_myList);
  UnmodifiableListView<UnmodifiableListView> get friendsLists =>
      UnmodifiableListView<UnmodifiableListView>(_friendsLists);
  UnmodifiableListView<String> get friendList =>
      UnmodifiableListView(_friendsList);

  int get length => _myList.length;

  void addProduct(Product product) {
    _myList.add(product);
    notifyListeners();
  }

  void removeProduct(int index) {
    _myList.removeAt(index);
    notifyListeners();
  }

  void addFriendList(String uid) {
    _friendsList.add(uid);
    notifyListeners();
  }

  void addFriendLists(List list) {
    _friendsLists.add(UnmodifiableListView(list));
    notifyListeners();
  }
}
