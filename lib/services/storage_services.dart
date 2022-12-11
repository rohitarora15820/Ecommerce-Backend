import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<void> uploadImage(XFile image) async {
    await _firebaseStorage
        .ref('product_images/${image.name}')
        .putFile(File(image.path));
  }

  Future<String> getDownloadURL(String imageName) async {
    return await _firebaseStorage
        .ref('product_images/$imageName')
        .getDownloadURL();
  }
}
