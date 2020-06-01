import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:shopping_for_friends/models/friend_list.dart';
import 'package:shopping_for_friends/models/product.dart';

class ContentProvider extends ChangeNotifier {
  List<Product> _myList = [];
  List<FriendList> _friendsLists = [];
  List<String> _selectedFriends = [];
  bool _state = false;
  int _total = 0;

  UnmodifiableListView<Product> get myList => UnmodifiableListView(_myList);
  UnmodifiableListView<FriendList> get friendsLists =>
      UnmodifiableListView(_friendsLists);

  int get length => _myList.length;
  int get friendsLength => _friendsLists.length;
  int get selectedFriends => _selectedFriends.length;
  bool get isFinished => _state;
  int get listTotal => _total;

  void finishList() {
    _state = true;
  }

  void addProduct(Product product) {
    _total = _total + product.price;
    _myList.add(product);
    notifyListeners();
  }

  void removeProduct(int index) {
    _total = _total - (_myList[index].quantity * _myList[index].price);
    _myList.removeAt(index);
    notifyListeners();
  }

  void addUnit(int index) {
    _total = _total + _myList[index].price;
    _myList[index].addUnit();
    notifyListeners();
  }

  void removeUnit(int index) {
    if (_myList[index].quantity == 1) {
      removeProduct(index);
    } else {
      _total = _total - _myList[index].price;
      _myList[index].removeUnit();
      notifyListeners();
    }
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
