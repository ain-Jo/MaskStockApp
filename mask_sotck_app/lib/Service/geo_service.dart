import 'package:geolocator/geolocator.dart';

class GeoService {
  Future<Position> getMyLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Stream<Position> getGeoStream() {
    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    Stream<Position> positionStream =
        geolocator.getPositionStream(locationOptions);
    return positionStream;
  }
}
