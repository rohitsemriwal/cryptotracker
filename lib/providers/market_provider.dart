import 'dart:async';
import 'dart:developer';

import 'package:cryptotracker/models/API.dart';
import 'package:cryptotracker/models/Cryptocurrency.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider with ChangeNotifier {

  bool isLoading = true;
  List<CryptoCurrency> markets = [];

  MarketProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> _markets = await API.getMarkets();

    List<CryptoCurrency> temp = [];
    for(var market in _markets) {
      CryptoCurrency newCrypto = CryptoCurrency.fromJSON(market);
      temp.add(newCrypto);
    }

    markets = temp;
    isLoading = false;
    notifyListeners();
  }

  CryptoCurrency fetchCryptoById(String id) {
    CryptoCurrency crypto = markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

}