class PharmacyGeo {
  final String code;
  final String name;
  final String address;
  final String type;
  final double latitude;
  final double longitude;
  final String stockAt;
  final String remainState;
  final String createdAt;

  PharmacyGeo(this.code, this.name, this.address, this.type, this.latitude,
      this.longitude, this.stockAt, this.remainState, this.createdAt);

  PharmacyGeo.fromMap(Map<String, dynamic> map)
      : code = map["code"],
        name = map["name"],
        address = map["addr"],
        type = map["type"],
        latitude = map["lat"],
        longitude = map["lng"],
        stockAt = map["stock_at"],
        remainState = map["remain_stat"],
        createdAt = map["created_at"];

  Map<String, dynamic> toMap() => {
        "code": code,
        "name": name,
        "addr": address,
        "type": type,
        "lat": latitude,
        "lng": longitude,
        "stock_at": stockAt,
        "remain_stat": remainState,
        "created_at": createdAt,
      };
}
