import 'package:cloud_firestore/cloud_firestore.dart';

class chatRoom{
  
  createChatRoom(String userId1, String userId2){
    String chatRoomId = userId1 +'_'+ userId2;
    List<String> users = [userId1, userId2];
    
    Map<String, dynamic> chatRoomMap = {
      "users":users,
      "chatRoomId":chatRoomId
    };
    Firestore.instance.collection('chatRoom').document(chatRoomId).setData(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }

  sendMessage(String chatRoomId, String userId, String message){
    Map<String, dynamic> messageMap = {
      "message": message,
      "sendBy": userId,
      "datetime": DateTime.now().millisecondsSinceEpoch
    };
    Firestore.instance.collection('chatRoom').document(chatRoomId).collection('chats').add(messageMap).catchError((e){
      print(e.toString());
    });
  }
  getConversation(String chatRoomId) async{
    return await Firestore.instance.collection('chatRoom').document(chatRoomId).collection('chats').orderBy("datetime").snapshots();
  }

  getChatRooms(String userId) async{
    return await Firestore.instance.collection("chatRoom").where("users", arrayContains: userId).snapshots()''

  }
}