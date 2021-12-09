import 'dart:developer';

import 'package:cryptotracker/services/AdHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdProvider with ChangeNotifier {

  bool isHomeBannerLoaded = false;
  late BannerAd homePageBanner;

  bool isDetailsBannerLoaded = false;
  late BannerAd detailsBanner;

  bool isFullPageAdLoaded = false;
  late InterstitialAd fullPageAd;


  void initializeHomePageBanner() async {
    homePageBanner = BannerAd(
      adUnitId: AdHelper.homePageBanner(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isHomeBannerLoaded = true;
        },
        onAdClosed: (ad) {
          isHomeBannerLoaded = false;
        },
        onAdFailedToLoad: (ad, err) {
          log(err.toString());
          isHomeBannerLoaded = false;
        }
      ),
      request: AdRequest(),
      size: AdSize.banner
    );

    await homePageBanner.load();
    notifyListeners();
  }

  void initializeDetailsPageBanner() async {
    detailsBanner = BannerAd(
      adUnitId: AdHelper.detailsBanner(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isDetailsBannerLoaded = true;
        },
        onAdClosed: (ad) {
          isDetailsBannerLoaded = false;
        },
        onAdFailedToLoad: (ad, err) {
          log(err.toString());
          isDetailsBannerLoaded = false;
        }
      ),
      request: AdRequest(),
      size: AdSize.banner
    );

    await detailsBanner.load();
    notifyListeners();
  }

  void initializeFullPageAd() async {
    
    await InterstitialAd.load(
      adUnitId: AdHelper.fullpageAd(),
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          fullPageAd = ad;
          isFullPageAdLoaded = true;
        },
        onAdFailedToLoad: (err) {
          log(err.toString());
          isFullPageAdLoaded = false;
        }
      ),
    );

    notifyListeners();

  }

}