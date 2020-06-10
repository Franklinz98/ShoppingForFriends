import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> createShoppingList(
    String userId, Map<String, dynamic> shoppingListMap) async {
  await Firestore.instance
      .collection('ShoppingList')
      .document(userId)
      .setData(shoppingListMap)
      .catchError((e) {
    print(e.toString());
  });
  return true;
}

Future<bool> updateList(
    String userId, Map<String, dynamic> shoppingListMap) async {
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
  await Firestore.instance
      .collection("ShoppingList")
      .document(userId)
      .updateData({'isPublic': true});
  return true;
}

Future<bool> userHasList(String uid) async {
  final snapshot =
      await Firestore.instance.collection("ShoppingList").document(uid).get();
  if (snapshot == null || !snapshot.exists) {
    return false;
  } else {
    return true;
  }
}

getPublicShoppingLists() {
  var snapshot = Firestore.instance
      .collection("ShoppingList")
      .where('isPublic', isEqualTo: true)
      .snapshots();
  return snapshot;
}
