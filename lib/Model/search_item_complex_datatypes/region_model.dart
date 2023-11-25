class Region {
  String? country;
  List<String>? cities;

  Region({this.country, this.cities});

  Region.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    cities = json['cities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['cities'] = cities;
    return data;
  }
}
