import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:storage_repository/storage_repository.dart';

class FirebaseStorageImpl implements StorageRepository {
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<String> uploadFile(String ref, File file) async {
    var storageRef = storage.ref().child(ref);
    var uploadTask = await storageRef.putFile(file);
    String downloadUrl = await uploadTask.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Future<String> uploadImageData(String ref, Uint8List fileData) async {
    var storageRef = storage.ref().child(ref);
    var uploadTask = await storageRef.putData(fileData);

    String downloadURL = await uploadTask.ref.getDownloadURL();
    return downloadURL;
  }
}
