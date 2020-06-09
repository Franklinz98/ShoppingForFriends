import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingList {
  Future<bool> createShoppingList(String userId, shoppingListMap) async{
    Firestore.instance
        .collection('ShoppingList')
        .document(userId)
        .setData(shoppingListMap)
        .catchError((e) {
      print(e.toString());
    });
    return true;
  }

  Future<bool> updateList(String userId, shoppingListMap) async {
    await Firestore.instance
        .collection('ShoppingList')
        .document(userId)
        .updateData(shoppingListMap)
        .catchError((error) {
      print("error: $error");
    });
    return true;
  }

  Future<bool> deteleList(String userId) async {
    await Firestore.instance
        .collection('ShoppingList')
        .document(userId)
        .delete()
        .catchError((error) {
      print("error: $error");
    });
    return true;
  }

  Future<bool> setShoppingListPublic(String userId) async {
    Firestore.instance
        .collection("ShoppingList")
        .document(userId)
        .updateData({'isPublic': true});
    return true;
  }

  getPublicShoppingLists() async {
    return await Firestore.instance
        .collection("ShoppingList")
        .where('isPublic', isEqualTo: true)
        .snapshots();
  }
}
