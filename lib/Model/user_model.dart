class UserModel {
  String? firstName;
  String? lastName;
  String? id;
  String? token;
  String? email;
  String? profile;
  String? city;
  UserModel({
    this.firstName,
    this.lastName,
    this.id,
    this.token,
    this.email,
    this.profile,
    this.city,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    id = json['id'];
    token = json['token'];
    email = json['email'];
    profile = json['profile'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['id'] = id;
    data['token'] = token;
    data['email'] = email;
    data['profile'] = profile;
    data['city'] = city;
    return data;
  }
}
