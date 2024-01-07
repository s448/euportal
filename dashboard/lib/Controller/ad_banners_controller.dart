import 'dart:typed_data';

import 'package:dashboard/Service/firebase_storage_services.dart';
import 'package:eup/Model/carousel_banner_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eup/BusinessLogic/Services/Implementation/banner_services.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_banners_services.dart';

class AdBannersController extends GetxController {
  final IBannerServices _services = BannerServiceImplementation();
  final ImageUploadService _imageUploadService = ImageUploadService();

  deleteBanner(String id) => _services.deleteBanner(id);
  RxString launchUrl = ''.obs;
  RxString bannerImgUrl = ''.obs;

  TextEditingController launchUrlField = TextEditingController();

  Rx<Uint8List> bannerImg = Rx<Uint8List>(Uint8List(0));
  pickBannerImg() async {
    bannerImg.value = await _imageUploadService.pickImage();
    update();
  }

  saveBanner() async {
    bannerImgUrl.value =
        (await _imageUploadService.uploadImage(bannerImg.value, "carousel")) ??
            '';
    CarouselBanner banner = CarouselBanner(
      bannerUrl: bannerImgUrl.value,
      launchUrl: launchUrl.value,
    );
    await _services.saveBanner(banner);
    launchUrlField.clear();
    bannerImg.value = Uint8List(0);
  }
}
