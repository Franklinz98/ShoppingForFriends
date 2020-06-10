import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_for_friends/models/chatroom.dart';
import 'package:shopping_for_friends/models/message.dart';

Future<bool> createChatRoom(
    String chatRoomId, List<String> uids, List<String> names) async {
  Map<String, dynamic> chatRoomMap = {
    "uids": uids,
    "chatRoomId": chatRoomId,
  };
  Map<String, dynamic> chatRoomPreviewMap = {
    "users": names,
    "uids": uids,
    "chatRoomId": chatRoomId,
    "lastMessage": null,
  };
  await Firestore.instance
      .collection('chatRoom')
      .document(chatRoomId)
      .setData(chatRoomMap)
      .catchError((e) {});
  await Firestore.instance
      .collection('chatRoomPreview')
      .document(chatRoomId)
      .setData(chatRoomPreviewMap)
      .catchError((e) {});
  return true;
}

Future<bool> sendMessage(String chatRoomId, Message message) async {
  Map<String, dynamic> chatRoomPreviewMap = {
    "lastMessage": message.toMap(),
  };
  await Firestore.instance
      .collection('chatRoom')
      .document(chatRoomId)
      .collection('chats')
      .add(message.toMap())
      .catchError((error) {});
  await Firestore.instance
      .collection('chatRoomPreview')
      .document(chatRoomId)
      .updateData(chatRoomPreviewMap)
      .catchError((e) {});
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

Future<List<String>> getChatRooms(String userId) async {
  List<String> rooms = [];
  var query = await Firestore.instance
      .collection("chatRoom")
      .where("uids", arrayContains: userId)
      .getDocuments();
  query.documents.forEach((chatRoomMap) {
    rooms.add(chatRoomMap.data['chatRoomId']);
    print(chatRoomMap.data['chatRoomId']);
  });
  return rooms;
}

Future<List<ChatRoom>> getChatRoompreview(String userId) async {
  List<ChatRoom> rooms = [];
  var query = await Firestore.instance
      .collection("chatRoomPreview")
      .where("uids", arrayContains: userId)
      .getDocuments();
  query.documents.forEach((chatRoomMap) {
    rooms.add(ChatRoom.fromMap(chatRoomMap.data));
  });
  return rooms;
}

Stream<QuerySnapshot> listenChats(String userId) {
  return Firestore.instance
      .collection("chatRoomPreview")
      .snapshots();
}
