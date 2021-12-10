import 'dart:developer';

import 'package:cryptotracker/services/AdHelper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdProvider with ChangeNotifier {

  bool isHomePageBannerLoaded = false;
  late BannerAd homePageBanner;

  bool isDetailsPageBannerLoaded = false;
  late BannerAd detailsPageBanner;

  bool isFullPageAdLoaded = false;
  late InterstitialAd fullPageAd;

  void initializeHomePageBanner() async {
    homePageBanner = BannerAd(
      adUnitId: AdHelper.homePageBanner(),
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log("HomePage Banner Loaded!");
          isHomePageBannerLoaded = true;
        },
        onAdClosed: (ad) {
          ad.dispose();
          isHomePageBannerLoaded = false;
        },
        onAdFailedToLoad: (ad, err) {
          log(err.toString());
          isHomePageBannerLoaded = false;
        }
      ),
    );

    await homePageBanner.load();
    notifyListeners();
  }

  void initializeDetailsPageBanner() async {
    detailsPageBanner = BannerAd(
      adUnitId: AdHelper.detailsPageBanner(),
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log("Details Banner Loaded!");
          isDetailsPageBannerLoaded = true;
        },
        onAdClosed: (ad) {
          ad.dispose();
          isDetailsPageBannerLoaded = false;
        },
        onAdFailedToLoad: (ad, err) {
          log(err.toString());
          isDetailsPageBannerLoaded = false;
        }
      ),
    );

    await detailsPageBanner.load();
    notifyListeners();
  }

  void initializeFullPageAd() async {
    await InterstitialAd.load(
      adUnitId: AdHelper.fullPageAd(),
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          log("Full Page Ad Loaded!");
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