import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat/core/enums/enums.dart';
import 'package:fire_chat/core/models/chat_tile_model.dart';
import 'package:fire_chat/core/models/user_model.dart';
import 'package:fire_chat/core/other/base_viewmodel.dart';
import 'package:fire_chat/core/services/chat_service.dart';

class ChatListViewmodel extends BaseViewmodel {
  final ChatService _chatService;
  final UserModel _currentUser;

  List<ChatTileModel> chats = [];
  List<ChatTileModel> filteredChats = [];

  StreamSubscription? _userSubscription;
  StreamSubscription? _chatRoomSubscription;

  ChatListViewmodel(this._chatService, this._currentUser) {
    _listenToUsers();
    _listenToChatRooms();
  }

  /// Listen to users collection live
  void _listenToUsers() {
    _userSubscription = FirebaseFirestore.instance
        .collection("users")
        .snapshots()
        .listen((snapshot) {
      _rebuildChatList();
    });
  }

  /// Listen to chatRooms where current user is a participant
  void _listenToChatRooms() {
    _chatRoomSubscription = FirebaseFirestore.instance
        .collection("chatRooms")
        .where("participants", arrayContains: _currentUser.uid)
        .snapshots()
        .listen((snapshot) {
      _rebuildChatList();
    });
  }

  /// Build chat list every time something changes
  Future<void> _rebuildChatList() async {
    setState(ViewState.loading);

    try {
      final usersSnap =
      await FirebaseFirestore.instance.collection("users").get();

      List<ChatTileModel> temp = [];

      for (var doc in usersSnap.docs) {
        if (doc.id == _currentUser.uid) continue;

        final user = UserModel.fromMap(doc.data());
        final otherUid = doc.id;

        final chatRoomId =
        _chatService.getChatRoomId(_currentUser.uid!, otherUid);

        final chatRoomDoc = await FirebaseFirestore.instance
            .collection("chatRooms")
            .doc(chatRoomId)
            .get();

        String? lastMessage;
        int? lastTimestamp;
        int unreadCount = 0;

        if (chatRoomDoc.exists) {
          final data = chatRoomDoc.data()!;

          if (data["lastMessage"] != null) {
            lastMessage = data["lastMessage"]["content"];
            lastTimestamp = data["lastMessage"]["timestamp"];
          }

          if (data["unreadCount"] != null &&
              data["unreadCount"][_currentUser.uid] != null) {
            unreadCount = data["unreadCount"][_currentUser.uid];
          }
        }

        temp.add(ChatTileModel(
          chatRoomId: chatRoomId,
          name: user.name!,
          imageUrl: user.imageUrl,
          otherUserId: otherUid,
          lastMessage: lastMessage,
          lastMessageTimestamp: lastTimestamp,
          unreadCount: unreadCount,
        ));
      }

      temp.sort((a, b) =>
          (b.lastMessageTimestamp ?? 0)
              .compareTo(a.lastMessageTimestamp ?? 0));

      chats = temp;
      filteredChats = List.from(chats);

      setState(ViewState.idle);
    } catch (e) {
      log("Chat list update error: $e");
      setState(ViewState.idle);
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredChats = List.from(chats);
    } else {
      filteredChats = chats
          .where(
              (c) => c.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    _chatRoomSubscription?.cancel();
    super.dispose();
  }
}
