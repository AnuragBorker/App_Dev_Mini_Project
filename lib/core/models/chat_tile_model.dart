class ChatTileModel {
  final String chatRoomId;
  final String name;
  final String? imageUrl;
  final String? lastMessage;
  final int? lastMessageTimestamp;
  final int unreadCount;
  final String otherUserId;

  ChatTileModel({
    required this.chatRoomId,
    required this.name,
    this.imageUrl,
    required this.otherUserId,
    this.lastMessage,
    this.lastMessageTimestamp,
    required this.unreadCount,
  });
}
