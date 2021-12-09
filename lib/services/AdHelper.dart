import 'dart:io';

class AdHelper {

  static String detailsBanner() {
    if(Platform.isAndroid) {
      return "ca-app-pub-8408301898096191/1935640491";
    }
    else {
      return "";
    }
  }

  static String homePageBanner() {
    if(Platform.isAndroid) {
      return "ca-app-pub-8408301898096191/6066457196";
    }
    else {
      return "";
    }
  }

  static String fullpageAd() {
    if(Platform.isAndroid) {
      return "ca-app-pub-8408301898096191/6557411781";
    }
    else {
      return "";
    }
  }

}