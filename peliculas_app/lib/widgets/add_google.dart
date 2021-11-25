
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

class Ads {
  static String appId = 'ca-app-pub-9020600069354260~9266249491';
  static String bannerPrueba = 'ca-app-pub-3940256099942544/6300978111';
  static String trailerPrueba = 'ca-app-pub-3940256099942544/1033173712';

  static String bannerHome = 'ca-app-pub-9020600069354260/1638330470';
  static String bannerDetails = 'ca-app-pub-9020600069354260/7110983150';
  static String trailer = 'ca-app-pub-9020600069354260/1283941403';

}

Future<AnchoredAdaptiveBannerAdSize?> anchoredAdaptiveBannerAdSize(
    BuildContext context) async {
  return await AdSize.getAnchoredAdaptiveBannerAdSize(
    MediaQuery.of(context).orientation == Orientation.portrait
        ? Orientation.portrait
        : Orientation.landscape,
    MediaQuery.of(context).size.width.toInt(),
  );
}