import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final _fire = FirebaseFirestore.instance;

  /// Create sorted chatRoomId
  String getChatRoomId(String uid1, String uid2) {
    return uid1.hashCode > uid2.hashCode
        ? "${uid1}_$uid2"
        : "${uid2}_$uid1";
  }

  /// Create chatroom if it doesn't exist
  Future<void> createChatRoomIfNotExists(
      String chatRoomId,
      String uid1,
      String uid2) async {
    final ref = _fire.collection("chatRooms").doc(chatRoomId);
    final doc = await ref.get();

    if (!doc.exists) {
      await ref.set({
        "participants": [uid1, uid2],
        "unreadCount": {
          uid1: 0,
          uid2: 0,
        },
        "lastMessage": null,
      });
    }
  }

  /// Save a new message
  Future<void> saveMessage(
      Map<String, dynamic> message,
      String chatRoomId,
      String receiverUid,
      ) async {
    try {
      final senderUid = message["senderId"];

      // 1. Ensure chatroom exists
      await createChatRoomIfNotExists(chatRoomId, senderUid, receiverUid);

      // 2. Save message
      await _fire
          .collection("chatRooms")
          .doc(chatRoomId)
          .collection("messages")
          .add(message);

      // 3. Update last message and increment unread for receiver
      await _fire.collection("chatRooms").doc(chatRoomId).update({
        "lastMessage": {
          "content": message["content"],
          "timestamp": message["timestamp"], // MUST be int
          "senderId": senderUid,
        },
        "unreadCount.$receiverUid": FieldValue.increment(1),
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Reset unread count when user opens chat
  Future<void> resetUnread(String chatRoomId, String uid) async {
    try {
      await _fire.collection("chatRooms").doc(chatRoomId).update({
        "unreadCount.$uid": 0,
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Stream chat rooms containing user
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatRooms(String uid) {
    return _fire
        .collection("chatRooms")
        .where("participants", arrayContains: uid)
        .snapshots();
  }

  /// Stream messages
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String chatRoomId) {
    return _fire
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
