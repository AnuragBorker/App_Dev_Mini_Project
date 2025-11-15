import 'package:fire_chat/core/services/auth_service.dart';
import 'package:fire_chat/ui/screens/other/user_provider.dart';
import 'package:fire_chat/ui/screens/bottom_navigation/profile/profile_screen_viewmodel.dart';
import 'package:fire_chat/ui/screens/bottom_navigation/profile/change_password_form.dart';
import 'package:fire_chat/ui/screens/bottom_navigation/profile/change_password_model.dart';
import 'package:fire_chat/ui/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;

    return ChangeNotifierProvider(
      create: (_) => ProfileScreenViewModel(),
      child: Consumer<ProfileScreenViewModel>(
        builder: (context, model, _) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header like ChatListScreen
                  Padding(
                    padding: EdgeInsets.only(top: 50.h, bottom: 20.h),
                    child: Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Avatar
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: currentUser?.imageUrl != null && currentUser!.imageUrl!.isNotEmpty
                          ? NetworkImage(currentUser.imageUrl!)
                          : null,
                      child: currentUser?.imageUrl == null || currentUser!.imageUrl!.isEmpty
                          ? Text(
                        (currentUser?.name?.isNotEmpty ?? false)
                            ? currentUser!.name![0]
                            : "?",
                        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      )
                          : null,
                    ),
                  ),

                  15.verticalSpace,

                  // User info
                  Center(
                    child: Column(
                      children: [
                        Text(
                          currentUser?.name ?? "User",
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          currentUser?.email ?? "example@email.com",
                          style:
                          const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  30.verticalSpace,

                  // Change password button
                  CustomButton(
                    buttonText: model.isLoading ? "Processing..." : "Change Password",
                    onPressed: model.isLoading
                        ? null
                        : () => _showChangePasswordBottomSheet(context),
                  ),

                  15.verticalSpace,

                  // Logout button
                  CustomButton(
                    buttonText: "Logout",
                    onPressed: () {
                      Provider.of<UserProvider>(context, listen: false).clearUser();
                      model.logout();
                      AuthService().logout();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Show modern bottom sheet for password change
  void _showChangePasswordBottomSheet(BuildContext context) {
    final viewModel = Provider.of<ProfileScreenViewModel>(context, listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return ChangeNotifierProvider(
          create: (_) => ChangePasswordModel(viewModel: viewModel),
          child: const ChangePasswordForm(),
        );
      },
    );
  }
}
