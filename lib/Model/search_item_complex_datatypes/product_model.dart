class Product {
  String? title;
  String? img;

  Product({this.title, this.img});

  Product.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['img'] = img;
    return data;
  }
}
