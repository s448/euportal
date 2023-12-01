class CarouselBanner {
  String? bannerUrl;
  String? launchUrl;

  CarouselBanner({this.bannerUrl, this.launchUrl});

  CarouselBanner.fromJson(Map<String, dynamic> json) {
    bannerUrl = json['banner_url'];
    launchUrl = json['launch_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['banner_url'] = bannerUrl;
    data['launch_url'] = launchUrl;
    return data;
  }
}
