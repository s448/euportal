// import 'package:eup/Model/search_item_complex_datatypes/item_location_model.dart';
// import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';
// import 'package:eup/Model/search_item_complex_datatypes/product_model.dart';
// import 'package:eup/Model/search_item_complex_datatypes/region_model.dart';

// class CoffeeShopItem {
//   String? title;
//   String? id;
//   String? logo;
//   String? portrait;
//   // String? spec;
//   String? phone;
//   bool? delivery;
//   String? workingHours;
//   List<Product>? products;
//   // Category? category;
//   Region? region;
//   ItemLocation? location;
//   bool? featuredPortrait;
//   bool? featuredLogo;
//   bool? isNew;

//   CoffeeShopItem({
//     this.title,
//     required this.id,
//     this.delivery,
//     this.location,
//     this.logo,
//     this.phone,
//     this.portrait,
//     this.products,
//     this.region,
//     // this.spec,
//     // this.category,
//     this.workingHours,
//     this.featuredLogo,
//     this.featuredPortrait,
//     this.isNew,
//   });

//   CoffeeShopItem.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     region = json['region'] != null ? Region.fromJson(json['region']) : null;
//     if (json['products'] != null) {
//       products = <Product>[];
//       json['products'].forEach((v) {
//         products!.add(Product.fromJson(v));
//       });
//     }

//     id = json['id'];
//     delivery = json['delivery'];
//     logo = json['logo'];
//     phone = json['phone'];
//     portrait = json['portrait'];
//     // spec = json['spec'];
//     // category =
//     //     json['category'] != null ? Category.fromJson(json['category']) : null;
//     location = json['location'] != null
//         ? ItemLocation.fromJson(json['location'])
//         : null;
//     workingHours = json['working_hours'];
//     featuredPortrait = json['featured_portrait'];
//     featuredLogo = json['featured_logo'];
//     isNew = json['is_new'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['title'] = title;
//     data['id'] = id;

//     if (region != null) {
//       data['region'] = region!.toJson();
//     }
//     if (products != null) {
//       data['products'] = products!.map((v) => v.toJson()).toList();
//     }

//     data['delivery'] = delivery;
//     data['logo'] = logo;
//     data['phone'] = phone;
//     data['portrait'] = portrait;
//     // data['spec'] = spec;
//     // if (category != null) {
//     //   data['type'] = category!.toJson();
//     // }
//     if (location != null) {
//       data['location'] = location!.toJson();
//     }
//     data['working_hours'] = workingHours;
//     data['featured_portrait'] = featuredPortrait;
//     data['featured_logo'] = featuredLogo;
//     data['is_new'] = isNew;
//     return data;
//   }
// }
