import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_for_friends/models/chat_room.dart';
import 'package:shopping_for_friends/models/message.dart';

Future<bool> createChatRoom(String userId1, String userId2) async {
  String chatRoomId = userId1 + '_' + userId2;
  List<String> users = [userId1, userId2];
  Map<String, dynamic> chatRoomMap = {"users": users, "chatRoomId": chatRoomId};
  await Firestore.instance
      .collection('chatRoom')
      .document(chatRoomId)
      .setData(chatRoomMap)
      .catchError((e) {
    print(e.toString());
  });
  return true;
}

Future<bool> sendMessage(String chatRoomId, Message message) async {
  await Firestore.instance
      .collection('chatRoom')
      .document(chatRoomId)
      .collection('chats')
      .add(message.toMap())
      .catchError((error) {
    print("error: $error");
  });
  return true;
}

getConversation(String chatRoomId) {
  var snapshot = Firestore.instance
      .collection('chatRoom')
      .document(chatRoomId)
      .collection('chats')
      .orderBy("datetime")
      .snapshots();
  return snapshot;
}

Future<List<ChatRoom>> getChatRooms(String userId) async {
  List<ChatRoom> rooms = [];
  var query = await Firestore.instance
      .collection("chatRoom")
      .where("users", arrayContains: userId)
      .getDocuments();
  query.documents.forEach((chatRoomMap) {
    rooms.add(
      ChatRoom.fromMap(
        chatRoomMap.data,
      ),
    );
  });
  print(rooms.asMap());
  return rooms;
}
