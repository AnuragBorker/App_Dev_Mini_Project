import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File image) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      final ref = _storage.ref("images/$timestamp.jpg");

      await ref.putFile(image);

      return await ref.getDownloadURL();
    } catch (e) {
      print("UPLOAD ERROR: $e");
      rethrow;
    }
  }
}
