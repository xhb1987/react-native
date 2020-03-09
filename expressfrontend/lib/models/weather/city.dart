class City {
  final String title;
  final String locationType;
  final int woeId;
  final String lattLong;

  City({this.title, this.locationType, this.woeId, this.lattLong});

  factory City.fromJSON(Map<String, dynamic> json) => City(
      title: json['title'] as String,
      locationType: json['location_type'] as String,
      woeId: json['woeid'] as int,
      lattLong: json['latt_long'] as String);
}
