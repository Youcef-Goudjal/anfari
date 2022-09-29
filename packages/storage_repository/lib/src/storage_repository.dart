import 'dart:io';
import 'dart:typed_data';

abstract class StorageRepository {
  /// upload file or image from file
  /// Return image URL
  Future<String> uploadFile(String ref, File file);

  /// upload image from file data
  /// returns image Url
  Future<String> uploadImageData(String ref, Uint8List fileData);
}
