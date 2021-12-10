import 'dart:io';

class AdHelper {

  static String homePageBanner() {
    if(Platform.isAndroid) {
      return "ca-app-pub-8408301898096191/1479472780";
    }
    else {
      return "";
    }
  }

  static String detailsPageBanner() {
    if(Platform.isAndroid) {
      return "ca-app-pub-8408301898096191/8807939095";
    }
    else {
      return "";
    }
  }

  static String fullPageAd() {
    if(Platform.isAndroid) {
      return "ca-app-pub-8408301898096191/9203524918";
    }
    else {
      return "";
    }
  }

}