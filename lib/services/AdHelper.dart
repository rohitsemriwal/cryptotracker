import 'dart:io';

class AdHelper {

  static String homePageBanner() {
    if(Platform.isAndroid) {
      return "-------- YOUR AD ID HERE --------";
    }
    else {
      return "";
    }
  }

  static String detailsPageBanner() {
    if(Platform.isAndroid) {
      return "-------- YOUR AD ID HERE --------";
    }
    else {
      return "";
    }
  }

  static String fullPageAd() {
    if(Platform.isAndroid) {
      return "-------- YOUR AD ID HERE --------";
    }
    else {
      return "";
    }
  }

}