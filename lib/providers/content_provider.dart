import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:shopping_for_friends/models/friend_list.dart';
import 'package:shopping_for_friends/models/product.dart';
import 'package:shopping_for_friends/models/user_model.dart';

class ContentProvider extends ChangeNotifier {
  User _user;
  List<Product> _myList = [];
  List<FriendList> _friendsLists = [];
  List<String> _selectedFriendsUid = [];
  bool _state = false;
  int _total = 0;
  int _selectedFriends = 0;

  UnmodifiableListView<Product> get myList => UnmodifiableListView(_myList);
  UnmodifiableListView<FriendList> get friendsLists =>
      UnmodifiableListView(_friendsLists);
  UnmodifiableListView<String> get selectedFriendsUid =>
      UnmodifiableListView(_selectedFriendsUid);

  int get length => _myList.length;
  int get friendsLength => _friendsLists.length;
  int get selectedFriends => _selectedFriends;
  bool get isFinished => _state;
  int get listTotal => _total;
  User get user => _user;

  void finishList() {
    _state = true;
    notifyListeners();
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
    return _selectedFriendsUid.contains(uid);
  }

  /* void switchFriendListState(FriendList friendList) {
    if (_selectedFriends.contains(friendList.uid)) {
      _selectedFriends.remove(friendList.uid);
      friendList.checked = false;
    } else {
      _selectedFriends.add(friendList.uid);
      friendList.checked = true;
    }
    notifyListeners();
  } */

  void switchFriendListState(FriendList friendList) {
    if (friendList.checked) {
      _selectedFriends = _selectedFriends - 1;
      _selectedFriendsUid.remove(friendList.uid);
      friendList.checked = false;
    } else {
      _selectedFriends = _selectedFriends + 1;
      _selectedFriendsUid.add(friendList.uid);
      friendList.checked = true;
    }
    notifyListeners();
  }

  void resetFriendLists() {
    _friendsLists.clear();
  }

  void addFriendList(FriendList list) {
    _friendsLists.add(list);
  }

  void updateUser(User user) {
    _user = user;
  }

  void purchaseProduct(Product product) {
    if (!product.purchased) {
      product.purchased = true;
      notifyListeners();
    }
  }

  bool testCheckout() {
    bool purchaseDone = true;
    _myList.forEach((product) {
      purchaseDone = purchaseDone & product.purchased;
    });
    _friendsLists.forEach((friendList) {
      if (friendList.checked) {
        friendList.list.forEach((product) {
          purchaseDone = purchaseDone & product.purchased;
        });
      }
    });
    return purchaseDone;
  }

  void clearMyList() {
    _myList.clear();
    _state = false;
    _selectedFriendsUid.clear();
    _selectedFriends = 0;
    notifyListeners();
  }

  Map<String, dynamic> myListToMap() {
    List<Map<String, dynamic>> _list = [];
    _myList.forEach((element) {
      _list.add(element.toMap());
    });
    return {
      'name': _user.name,
      'uid': _user.uid,
      'total': _total,
      'list': _list,
      'isPublic': _state
    };
  }
}
