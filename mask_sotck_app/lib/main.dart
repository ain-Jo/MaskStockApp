import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:mask_sotck_app/Api/mask_api.dart';
import 'package:mask_sotck_app/Service/geo_service.dart';
import 'package:mask_sotck_app/Service/url_service.dart';
import 'package:provider/provider.dart';
import 'Api/repository.dart';
import 'View/views.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiProvider(
          providers: [
            Provider<Repository>(
              create: (BuildContext context) => Repository(MaskApi()),
            ),
            Provider<GeoService>(
              create: (BuildContext context) => GeoService(),
            ),
            Provider<UrlService>(
              create: (BuildContext context) => UrlService(),
            ),
          ],
          child: Home(),
        ),
      ),
    );
  }
}
