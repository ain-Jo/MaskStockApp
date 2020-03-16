import 'package:mask_sotck_app/Api/mask_api.dart';
import 'package:mask_sotck_app/Model/location_request.dart';
import 'package:mask_sotck_app/Model/pharmacy_geo.dart';

class Repository {
  final MaskApi maskApi;

  Repository(this.maskApi);

  Future<List<PharmacyGeo>> getNearByMaskStock(LocationReq req) =>
      maskApi.getNearByMaskStock(req);
}
