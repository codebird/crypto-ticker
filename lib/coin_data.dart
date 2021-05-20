import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

import 'constants.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'XCH',
  'XRP',
];

class CoinData {
  Future<double> getData(String currency, String crypto) async {
    double rate = 0.0;
    var response = await http.get(
      Uri.parse('$kBaseURL$crypto/$currency?apikey=$kApiKey'),
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      rate = body['rate'];
    }
    return rate;
  }
}
