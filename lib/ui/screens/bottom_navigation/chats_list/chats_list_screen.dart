import 'package:fire_chat/core/constants/colors.dart';
import 'package:fire_chat/core/constants/strings.dart';
import 'package:fire_chat/core/constants/styles.dart';
import 'package:fire_chat/core/enums/enums.dart';
import 'package:fire_chat/core/models/chat_tile_model.dart';
import 'package:fire_chat/core/services/chat_service.dart';
import 'package:fire_chat/ui/screens/bottom_navigation/chats_list/chat_list_viewmodel.dart';
import 'package:fire_chat/ui/screens/other/user_provider.dart';
import 'package:fire_chat/ui/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat/core/models/user_model.dart';

class ChatsListScreen extends StatelessWidget {
  const ChatsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;

    return ChangeNotifierProvider(
      create: (_) => ChatListViewmodel(ChatService(), currentUser!),
      child: Consumer<ChatListViewmodel>(
        builder: (context, model, _) {
          return Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 1.sw * 0.05, vertical: 10.h),
            child: Column(
              children: [
                30.verticalSpace,
                Align(alignment: Alignment.centerLeft, child: Text("Chats", style: h)),
                20.verticalSpace,
                CustomTextField(
                  isSearch: true,
                  hintText: "Search here...",
                  onChanged: model.search,
                ),
                10.verticalSpace,
                model.state == ViewState.loading
                    ? const Expanded(child: Center(child: CircularProgressIndicator()))
                    : model.filteredChats.isEmpty
                    ? const Expanded(child: Center(child: Text("No Chats yet")))
                    : Expanded(
                  child: ListView.separated(
                    itemCount: model.filteredChats.length,
                    separatorBuilder: (_, __) => 8.verticalSpace,
                    itemBuilder: (context, index) {
                      final chat = model.filteredChats[index];

                      return ChatTile(
                        chat: chat,
                        onTap: () async {
                          try {
                            // fetch the full user document for the other user
                            final userDoc = await FirebaseFirestore.instance
                                .collection('users')
                                .doc(chat.otherUserId)
                                .get();

                            if (!userDoc.exists || userDoc.data() == null) {
                              // optional: show an error/snackbar
                              return;
                            }

                            // create UserModel (your UserModel.fromMap expects a single map)
                            final userModel = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);

                            // navigate, passing a UserModel as the route expects
                            Navigator.pushNamed(context, chatRoom, arguments: userModel);
                          } catch (e) {
                            // optional: show error to user or log
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to open chat")));
                            rethrow;
                          }
                        },
                      );

                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// ---------------------------------------------------------------------------------
/// ChatTile widget (keeps UI & imports cohesive; uses ChatTileModel)
/// ---------------------------------------------------------------------------------
class ChatTile extends StatelessWidget {
  const ChatTile({super.key, required this.chat, this.onTap});

  final ChatTileModel chat;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: grey.withValues(alpha: 0.12),
      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      leading: chat.imageUrl == null
          ? CircleAvatar(
        backgroundColor: grey.withValues(alpha: 0.5),
        radius: 25,
        child: Text(
          chat.name.isNotEmpty ? chat.name[0] : "?",
          style: h,
        ),
      )
          : ClipOval(
        child: Image.network(
          chat.imageUrl!,
          height: 50,
          width: 50,
          fit: BoxFit.fill,
          errorBuilder: (_, __, ___) => CircleAvatar(
            backgroundColor: grey.withValues(alpha: 0.5),
            radius: 25,
            child: Text(chat.name.isNotEmpty ? chat.name[0] : "?", style: h),
          ),
        ),
      ),
      title: Text(chat.name),
      subtitle: Text(
        chat.lastMessage ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            chat.lastMessageTimestamp == null ? "" : _formatTime(chat.lastMessageTimestamp!),
            style: const TextStyle(color: grey),
          ),
          8.verticalSpace,
          chat.unreadCount == 0
              ? const SizedBox(height: 15)
              : CircleAvatar(
            radius: 9.r,
            backgroundColor: primary,
            child: Text(
              "${chat.unreadCount}",
              style: small.copyWith(color: white),
            ),
          )
        ],
      ),
    );
  }

  String _formatTime(int timestamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime now = DateTime.now();

    int minutes = now.difference(time).inMinutes;
    if (minutes < 60) {
      return "$minutes min ago";
    }
    int hours = now.difference(time).inHours;
    if (hours < 24) {
      return "$hours hours ago";
    }
    return "${time.day}/${time.month}/${time.year}";
  }
}
