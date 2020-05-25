import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:shopping_for_friends/models/friend_list.dart';
import 'package:shopping_for_friends/models/product.dart';

class ContentProvider extends ChangeNotifier {
  List<Product> _myList = [];
  List<FriendList> _friendsLists = [];
  List<String> _selectedFriends = [];

  UnmodifiableListView<Product> get myList => UnmodifiableListView(_myList);
  UnmodifiableListView<FriendList> get friendsLists =>
      UnmodifiableListView(_friendsLists);

  int get length => _myList.length;
  int get friendsLength => _friendsLists.length;

  void addProduct(Product product) {
    _myList.add(product);
    notifyListeners();
  }

  void removeProduct(int index) {
    _myList.removeAt(index);
    notifyListeners();
  }

  void addUnit(int index) {
    _myList[index].addUnit();
    notifyListeners();
  }

  void removeUnit(int index) {
    _myList[index].removeUnit();
    notifyListeners();
  }

  bool isSelected(String uid) {
    return _selectedFriends.contains(uid);
  }

  void switchFriendListState(FriendList friendList) {
    if (_selectedFriends.contains(friendList.uid)) {
      _selectedFriends.remove(friendList.uid);
      friendList.checked = false;
    } else {
      _selectedFriends.add(friendList.uid);
      friendList.checked = true;
    }
    notifyListeners();
  }

  void resetFriendLists() {
    _friendsLists.clear();
  }

  void addFriendLists(List<FriendList> list) {
    _friendsLists.addAll(list);
    notifyListeners();
  }
}
