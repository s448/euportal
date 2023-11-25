class Region {
  String? id;
  String? country;
  List<String>? cities;

  Region({this.country, this.cities, this.id});

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    cities = json['cities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country'] = country;
    data['cities'] = cities;
    return data;
  }
}
