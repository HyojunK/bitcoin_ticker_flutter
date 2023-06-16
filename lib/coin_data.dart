import 'package:http/http.dart' as http;
import 'dart:convert';

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

const coinapiUrl = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'personal api key';

class CoinData {
  Future getData(String? selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      final uri =
          Uri.parse('$coinapiUrl/$crypto/$selectedCurrency?apikey=$apiKey');

      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double price = decodedData['rate'];

        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
      }
    }

    return cryptoPrices;
  }
}
