import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileScreenViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;

  // Quote State
  String quote = "Fetching quote...";

  ProfileScreenViewModel() {
    loadQuote();
    startAutoRefresh();
  }

  // Fetch Quote from REST API
  Future<void> loadQuote() async {
    try {
      final url = Uri.parse("https://zenquotes.io/api/random");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        quote = "\"${data[0]['q']}\" — ${data[0]['a']}";
      } else {
        quote = "Stay positive and keep moving forward.";
      }
    } catch (e) {
      quote = "Believe in yourself, even when no one else does.";
    }

    notifyListeners();
  }

  // Auto-refresh every 30 minutes
  void startAutoRefresh() {
    Future.delayed(const Duration(minutes: 30), () async {
      await loadQuote();
      startAutoRefresh();
    });
  }

  // Logout user
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Change password
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
