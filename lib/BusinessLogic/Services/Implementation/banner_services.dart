import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_banners_services.dart';
import 'package:get/get.dart';

class BannerServiceImplementation implements IBannerServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  deleteBanner(String id) async {
    try {
      await _firestore.collection('carousel').doc(id).delete();
      Get.snackbar("Banner deleted successfully", '');
    } catch (e) {
      Get.snackbar("Failed to delete the banner", '');
      log(e.toString());
    }
  }
}
