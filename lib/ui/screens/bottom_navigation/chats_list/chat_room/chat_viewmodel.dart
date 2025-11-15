import 'dart:async';
import 'dart:developer';

import 'package:fire_chat/core/models/message_model.dart';
import 'package:fire_chat/core/models/user_model.dart';
import 'package:fire_chat/core/other/base_viewmodel.dart';
import 'package:fire_chat/core/services/chat_service.dart';
import 'package:flutter/material.dart';

class ChatViewmodel extends BaseViewmodel {
  final ChatService _chatService;
  final UserModel _currentUser;
  final UserModel _receiver;

  StreamSubscription? _subscription;

  ChatViewmodel(this._chatService, this._currentUser, this._receiver) {
    _setChatRoomId();
    _listenToMessages();

    // Reset unread as soon as user enters the chat
    _chatService.resetUnread(chatRoomId, _currentUser.uid!);
  }

  String chatRoomId = "";

  final _messageController = TextEditingController();
  TextEditingController get controller => _messageController;

  List<Message> _messages = [];
  List<Message> get messages => _messages;

  /// Build chatRoomId from sorted UIDs
  void _setChatRoomId() {
    chatRoomId = _chatService.getChatRoomId(
      _currentUser.uid!,
      _receiver.uid!,
    );
  }

  /// Listen to all messages in the chat
  void _listenToMessages() {
    _subscription = _chatService.getMessages(chatRoomId).listen((snapshot) {
      _messages =
          snapshot.docs.map((e) => Message.fromMap(e.data())).toList();
      notifyListeners();
    });
  }

  Future<void> saveMessage() async {
    try {
      if (_messageController.text.trim().isEmpty) {
        throw Exception("Please enter some text");
      }

      log("Send Message");

      final now = DateTime.now();

      final message = Message(
        id: now.millisecondsSinceEpoch.toString(),
        content: _messageController.text.trim(),
        senderId: _currentUser.uid,
        receiverId: _receiver.uid,
        timestamp: now,  // 🔥 FIXED
      );

      await _chatService.saveMessage(
        message.toMap(),
        chatRoomId,
        _receiver.uid!,
      );

      _messageController.clear();

    } catch (e) {
      log("Send Message Error: $e");
      rethrow;
    }
  }


  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
