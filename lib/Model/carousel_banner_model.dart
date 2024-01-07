class CarouselBanner {
  String? bannerUrl;
  String? launchUrl;
  String? id;

  CarouselBanner({this.bannerUrl, this.launchUrl, this.id});

  CarouselBanner.fromJson(Map<String, dynamic> json) {
    bannerUrl = json['banner_url'];
    launchUrl = json['launch_url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['banner_url'] = bannerUrl;
    data['launch_url'] = launchUrl;
    data['id'] = id;
    return data;
  }
}
