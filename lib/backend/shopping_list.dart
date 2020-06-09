import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingList{
    createShoppingList(String userId, shoppingListMap){
      Firestore.instance.collection('ShoppingList').document(userId).setData(shoppingListMap).catchError((e){
      print(e.toString());
    });
    }
    
    setShoppingListPublic(String userId)async{
      return await Firestore.instance.collection("ShoppingList").document(userId).updateData({'isPublic': true});
    }

    getPublicShoppingLists() async{
    return await Firestore.instance.collection("ShoppingList").where('isPublic', isEqualTo: true).snapshots();
  }
}