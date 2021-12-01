import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class API {

  static Future<List<dynamic>> getMarkets() async {
    try {
       Uri requestPath = Uri.parse("https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=20&page=1&sparkline=false");

      var response = await http.get(requestPath);
      var decodedResponse = jsonDecode(response.body);

      List<dynamic> markets = decodedResponse as List<dynamic>;
      return markets;
    } catch(ex) {
      return [];
    }
  }

}