class ItemRegion {
  String? country;
  String? city;

  ItemRegion({this.city, this.country});

  ItemRegion.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['country'] = country;
    return data;
  }
}
