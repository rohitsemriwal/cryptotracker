import 'dart:async';
import 'dart:developer';

import 'package:cryptotracker/services/API.dart';
import 'package:cryptotracker/models/Cryptocurrency.dart';
import 'package:cryptotracker/services/LocalStorage.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider with ChangeNotifier {

  bool isLoading = true;
  List<CryptoCurrency> markets = [];

  MarketProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> _markets = await API.getMarkets();
    List<String> favorites = await LocalStorage.fetchFavorites();

    List<CryptoCurrency> temp = [];
    for(var market in _markets) {
      CryptoCurrency newCrypto = CryptoCurrency.fromJSON(market);

      if(favorites.contains(newCrypto.id!)) {
        newCrypto.isFavorite = true;
      }

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

  void addFavorite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavorite = true;
    await LocalStorage.addFavorite(crypto.id!);
    notifyListeners();
  }

  void removeFavorite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavorite = false;
    await LocalStorage.removeFavorite(crypto.id!);
    notifyListeners();
  }

}