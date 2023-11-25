import 'package:eup/Model/search_item_complex_datatypes/item_location_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/product_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/region_model.dart';

class Item {
  String? title;
  String? id;
  String? logo;
  String? portrait;
  String? spec;
  String? phone;
  bool? delivery;
  String? workingHours;
  List<Product>? products;
  ItemType? type;
  Region? region;
  ItemLocation? location;

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
    this.spec,
    this.type,
    this.workingHours,
  });

  Item.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    region = json['region'] != null ? Region.fromJson(json['region']) : null;
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
    spec = json['spec'];
    type = json['type'] != null ? ItemType.fromJson(json['type']) : null;
    location = json['location'] != null
        ? ItemLocation.fromJson(json['location'])
        : null;
    workingHours = json['working_hours'];
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
    data['spec'] = spec;
    if (type != null) {
      data['type'] = type!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['working_hours'] = workingHours;

    return data;
  }
}
