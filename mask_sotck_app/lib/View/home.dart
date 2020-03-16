import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mask_sotck_app/Api/repository.dart';
import 'package:mask_sotck_app/Model/models.dart';
import 'package:mask_sotck_app/Service/geo_service.dart';
import 'package:mask_sotck_app/Service/url_service.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController ctrl = TextEditingController();

  int range = 1000;
  double myLat;
  double myLng;

  void moveMap(PharmacyGeo item) {
    //url로 구글 지도로 이동
    String url =
        "http://maps.google.com/maps?q=${item.latitude},${item.longitude}&z?hl=ko";
    Provider.of<UrlService>(context, listen: false)
        .launchUrl(url)
        .catchError((err) => print("구글맵 이동 에러 : $err"));
    BotToast.showText(text: "이동합니다.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          upperBar(),
          Expanded(
            child: _list(),
          ),
        ],
      ),
    );
  }

  Widget upperBar() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                controller: ctrl,
              ),
            ),
            RaisedButton(
                child: Text("범위 변경"),
                onPressed: () {
                  setState(() {
                    range = int.parse(ctrl.text.trim());
                  });
                })
          ],
        ),
      ),
    );
  }

  Widget _list() {
    return StreamBuilder<Position>(
        stream: Provider.of<GeoService>(context).getGeoStream(),
        builder: (context, geoSnapshot) {
          if (geoSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("위치를 받아오고 있습니다."),
            );
          }
          if (geoSnapshot.hasData) {
            print("현재 위도 : ${geoSnapshot.data.latitude}");
            print("현재 경도 : ${geoSnapshot.data.longitude}");
            return FutureBuilder<List<PharmacyGeo>>(
                future: Provider.of<Repository>(context).getNearByMaskStock(
                    LocationReq(geoSnapshot.data.latitude,
                        geoSnapshot.data.longitude, range)),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.length > 0) {
                    return Container(
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            PharmacyGeo item = snapshot.data[index];
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black)),
                              padding: EdgeInsets.all(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () => moveMap(item),
                                    child: Text(
                                      snapshot.data[index].name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text("주소 : ${snapshot.data[index].address}"),
                                  Text(
                                      "재고확보일자 : ${snapshot.data[index].stockAt}"),
                                  Text(
                                    "마스크보유정도 : ${snapshot.data[index].remainState}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                  Text(
                                      "작성일자 : ${snapshot.data[index].createdAt}"),
                                ],
                              ),
                            );
                          }),
                    );
                  } else {
                    return Container(
                      child: Center(
                        child: Text("데이터가 없습니다."),
                      ),
                    );
                  }
                });
          } else {
            return Center(
              child: Text("GPS에 문제가 있습니다."),
            );
          }
        });
  }
}
