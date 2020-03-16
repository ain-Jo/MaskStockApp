class LocationReq {
  final double latitude;
  final double longitude;
  final int range;

  LocationReq(this.latitude, this.longitude, this.range);

  LocationReq.fromMap(Map<String, dynamic> map)
      : latitude = map["lat"],
        longitude = map["lng"],
        range = map["range"];

  Map<String, dynamic> toMap() => {
        "lat": latitude,
        "lng": longitude,
        "range": range,
      };
}
