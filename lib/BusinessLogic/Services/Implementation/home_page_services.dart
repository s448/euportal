import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eup/BusinessLogic/Services/Interface/i_home_page_services.dart';
import 'package:eup/Model/carousel_banner_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';
import 'package:eup/Model/region_model.dart';
import 'package:eup/Model/search_item_model.dart';

class HomePageServices implements IhomePageServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<String> getSearchResult(String q) async {
    return "this is result";
  }

  @override
  Future<List<Category>> getSearchCategories() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('category').get();

      return snapshot.docs.map((DocumentSnapshot document) {
        final data = document.data() as Map<String, dynamic>;
        return Category.fromJson(data);
      }).toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  @override
  Future<List<Region>> getRegions() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('region').get();

      return snapshot.docs.map((DocumentSnapshot document) {
        final data = document.data() as Map<String, dynamic>;
        return Region.fromJson(data);
      }).toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  @override
  Stream<List<Item>> portratStream() => FirebaseFirestore.instance
      .collection('selection')
      .where('featured_portrait', isEqualTo: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());

  @override
  Stream<List<Item>> logoStream() => FirebaseFirestore.instance
      .collection('selection')
      .where('featured_logo', isEqualTo: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());

  @override
  Stream<List<Item>> filterStream(
          String country, String city, String category) =>
      FirebaseFirestore.instance
          .collection('selection')
          .where('region.country', isEqualTo: country)
          .where('region.city', isEqualTo: city)
          .where('category.title', isEqualTo: category)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());

  @override
  Stream<List<CarouselBanner>> carouselStream() => FirebaseFirestore.instance
      .collection('carousel')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => CarouselBanner.fromJson(doc.data()))
          .toList());
}
