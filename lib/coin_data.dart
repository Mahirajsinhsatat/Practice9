import 'dart:convert';

import 'package:http/http.dart' as http;

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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '1425e095-f0d8-4388-b7bb-c6cd3c4a14aa';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      String requestURl =
          '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';

      http.Response response = await http.get(Uri.parse(requestURl));

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastprice = decodedData['rate'];

        cryptoPrices[crypto] = lastprice.toStringAsFixed(0);
        print(selectedCurrency);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}

// const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
// const apiKey = "1425e095-f0d8-4388-b7bb-c6cd3c4a14aa";
//
// class CoinData {
//
//   getCoinData() async {
//
//     String requestURL = '$coinAPIURL/BTC/USD?apikey=$apiKey';
//
//     http.Response response = await http.get(Uri.parse(requestURL));
//
//     if(response.statusCode == 200){
//
//       var decoded = jsonDecode(response.body);
//
//       var lastprice = decoded['rate'];
//       return lastprice;
//
//     }else {
//       //10. Handle any errors that occur during the request.
//       print(response.statusCode);
//       //Optional: throw an error if our request fails.
//       throw 'Problem with the get request';
//     }
//
//   }
//
// }
