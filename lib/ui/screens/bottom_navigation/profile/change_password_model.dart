import 'package:flutter/material.dart';
import 'profile_screen_viewmodel.dart';

class ChangePasswordModel extends ChangeNotifier {
  final ProfileScreenViewModel viewModel;

  ChangePasswordModel({required this.viewModel});

  final currentController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();

  bool showCurrent = false;
  bool showNew = false;
  bool showConfirm = false;

  void toggleCurrent() {
    showCurrent = !showCurrent;
    notifyListeners();
  }

  void toggleNew() {
    showNew = !showNew;
    notifyListeners();
  }

  void toggleConfirm() {
    showConfirm = !showConfirm;
    notifyListeners();
  }

  /// Validate input before sending to Firebase
  String? validate() {
    final current = currentController.text.trim();
    final newPass = newController.text.trim();
    final confirmPass = confirmController.text.trim();

    if (current.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      return "Please fill all fields";
    }

    if (newPass.length < 6) {
      return "New password must be at least 6 characters";
    }

    if (newPass != confirmPass) {
      return "Passwords do not match";
    }

    return null; // Valid
  }

  /// Submit password change
  Future<String?> submit() async {
    final error = await viewModel.changePassword(
        currentPassword: currentController.text.trim(),
        newPassword: newController.text.trim());
    return error;
  }

  /// Dispose controllers
  void disposeControllers() {
    currentController.dispose();
    newController.dispose();
    confirmController.dispose();
  }
}
