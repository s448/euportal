class Category {
  String? title;
  String? id;

  Category({this.title, this.id});

  Category.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['id'] = id;
    return data;
  }
}
