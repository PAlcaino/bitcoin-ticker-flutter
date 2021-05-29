import 'dart:convert';
import 'dart:io';

import 'package:bitcoin_ticker/services/networking.dart';
import 'package:http/http.dart';

const _apiKey = 'ADBB69ED-7240-4B1B-A015-5A4EAAD3CD4B';

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
];

class CoinData {
  Future<dynamic> getCoinDataByCurrency(String coin, String currency) async {
    Networking networking = Networking();
    Uri uri = Uri.https('rest.coinapi.io', '/v1/exchangerate/$coin/$currency',
        {'apikey': _apiKey});

    Response response = await networking.getData(uri);
    if (response.statusCode == HttpStatus.ok) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Http error ${response.statusCode}, error message: ${response.body}');
    }
  }
}
