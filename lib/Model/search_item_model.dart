import 'package:eup/Model/search_item_complex_datatypes/item_location_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_region_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/product_model.dart';

class Item {
  String? title;
  String? id;
  String? logo;
  String? portrait;
  String? description;
  String? phone;
  bool? delivery;
  String? workingHours;
  List<Product>? products;
  Category? category;
  ItemRegion? region;
  ItemLocation? location;
  bool? featuredPortrait;
  bool? featuredLogo;
  bool? isNew;

  //mosque
  String? mosqueCapacity;
  bool? mosqueAblutionFacilities;
  bool? womenPrayerRoom;
  bool? lessonAfterEshaa;
  bool? allPrayers;

  //dr
  String? fb;
  String? insta;
  Item({
    this.title,
    required this.id,
    this.delivery,
    this.location,
    this.logo,
    this.phone,
    this.portrait,
    this.products,
    this.region,
    this.description,
    this.category,
    this.workingHours,
    this.featuredLogo,
    this.featuredPortrait,
    this.isNew,
    this.allPrayers,
    this.lessonAfterEshaa,
    this.mosqueAblutionFacilities,
    this.mosqueCapacity,
    this.womenPrayerRoom,
    this.fb,
    this.insta,
  });

  Item.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    region =
        json['region'] != null ? ItemRegion.fromJson(json['region']) : null;
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }

    id = json['id'];
    delivery = json['delivery'];
    logo = json['logo'];
    phone = json['phone'];
    portrait = json['portrait'];
    description = json['description'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    location = json['location'] != null
        ? ItemLocation.fromJson(json['location'])
        : null;
    workingHours = json['working_hours'];
    featuredPortrait = json['featured_portrait'];
    featuredLogo = json['featured_logo'];
    isNew = json['is_new'];

    mosqueCapacity = json['mosque_capacity'];
    mosqueAblutionFacilities = json['ablution_facilities'];
    womenPrayerRoom = json['women_prayer_room'];
    lessonAfterEshaa = json['lesson_after_ishaa'];
    allPrayers = json['all_prayers'];

    fb = json['fb'];
    insta = json['insta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['id'] = id;

    if (region != null) {
      data['region'] = region!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }

    data['delivery'] = delivery;
    data['logo'] = logo;
    data['phone'] = phone;
    data['portrait'] = portrait;
    data['description'] = description;
    if (category != null) {
      data['type'] = category!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['working_hours'] = workingHours;
    data['featured_portrait'] = featuredPortrait;
    data['featured_logo'] = featuredLogo;
    data['is_new'] = isNew;

    data['mosque_capacity'] = mosqueCapacity;
    data['ablution_facilities'] = mosqueAblutionFacilities;
    data['women_prayer_room'] = womenPrayerRoom;
    data['lesson_after_ishaa'] = lessonAfterEshaa;
    data['all_prayers'] = allPrayers;

    data['fb'] = fb;
    data['insta'] = insta;
    return data;
  }
}
