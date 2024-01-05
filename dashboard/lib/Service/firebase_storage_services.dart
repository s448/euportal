import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker_web/image_picker_web.dart';

class ImageUploadService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(String folder) async {
    try {
      String url = '';
      Uint8List? image = await ImagePickerWeb.getImageAsBytes();

      if (image != null) {
        Reference ref = _storage.ref("$folder/${DateTime.now()}.png");
        UploadTask task = ref.putData(image);

        await task.whenComplete(() async {
          url = await task.snapshot.ref.getDownloadURL();
        });
      }
      return url;
    } catch (e) {
      log(e.toString());
      return '';
    }
  }
}
