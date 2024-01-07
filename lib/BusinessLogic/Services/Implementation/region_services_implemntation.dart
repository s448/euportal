import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_region_services.dart';
import 'package:eup/Model/region_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RegionServiceImplementation implements IRegionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  deleteRegion(String id) async {
    try {
      await _firestore.collection('region').doc(id).delete();
      Get.snackbar("Country deleted successfully", '');
    } catch (e) {
      Get.snackbar("Failed to delete the Country", '');
      log(e.toString());
    }
  }

  @override
  Stream<List<Region>> regionsStream() =>
      _firestore.collection('region').snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Region.fromJson(doc.data())).toList());

  @override
  addRegion(Region region) async {
    try {
      var id = const Uuid().v1();
      region.id = id;
      await _firestore.collection('region').doc(id).set(region.toJson());
      Get.snackbar("Country saved successfully", '');
    } catch (e) {
      Get.snackbar("Failed to save the Country", '');
      log(e.toString());
    }
  }
}
