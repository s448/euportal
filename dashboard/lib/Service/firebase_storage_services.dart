import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker_web/image_picker_web.dart';

class ImageUploadService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<Uint8List> pickImage() async {
    try {
      Uint8List? image = await ImagePickerWeb.getImageAsBytes();
      if (image != null) {
        return image;
      }
      return Uint8List(0);
    } catch (e) {
      log(e.toString());
      return Uint8List(0);
    }
  }

  Future<String?> uploadImage(Uint8List image, String folder) async {
    String? url;
    Reference ref = _storage.ref("$folder/${DateTime.now()}.png");
    UploadTask task = ref.putData(image);

    await task.whenComplete(() async {
      url = await task.snapshot.ref.getDownloadURL();
    });

    return url;
  }
}
