import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mask_sotck_app/Model/location_request.dart';
import 'package:mask_sotck_app/Model/pharmacy_geo.dart';

class MaskApi {
  final host = "https://desolate-lowlands-02527.herokuapp.com/";

  Future<List<PharmacyGeo>> getNearByMaskStock(LocationReq req) async {
    try {
      http.Response res = await http.post(
        host,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          req.toMap(),
        ),
      );

      return (json.decode(res.body) as List)
          .map((data) => PharmacyGeo.fromMap(data))
          .toList();
    } catch (err) {
      print("마스크 Api 통신 에러 : $err");
    }
  }
}
