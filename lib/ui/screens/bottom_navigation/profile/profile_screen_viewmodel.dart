import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreenViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;

  /// Logout the user
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// Change password using current password and new password
  Future<String?> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final user = _auth.currentUser;
      if (user == null) return "User not logged in";

      // Re-authenticate
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPassword);

      isLoading = false;
      notifyListeners();

      return null; // Success
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      return e.message;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return "An unknown error occurred";
    }
  }
}
