import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice9/coin_data.dart';
import 'dart:io' show Platform;

import 'package:practice9/crypto_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'AUD';

  //   List<DropdownMenuItem<String>> getDropdownItems(){
  //     List<DropdownMenuItem<String>> dropdownItems = [];
  //
  //     for (int i = 0; i < currenciesList.length; i++){
  //       String currency = currenciesList[i];
  //       var newItem = DropdownMenuItem(
  //         child: Text(currency),
  //         value: currency,
  //     );
  //       dropdownItems.add(newItem);
  //   }
  //   return dropdownItems;
  // }


  DropdownButton<String> androidDropdown() {

    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  CupertinoPicker iOSPicker(){
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectdIndex) {
          setState(() {
            selectedCurrency = currenciesList[selectdIndex];
            getData();
          });
        },
        children: pickerItems,
    );
  }
  // Widget getPicker() {
  //   if (Platform.isIOS) {
  //     return iOSPicker();
  //   } else if (Platform.isAndroid) {
  //     return androidDropdown();
  //   } else {
  //     // Default case for unsupported platforms.
  //     return Text('Picker not available on this platform');
  //   }
  // }

  // String bitcoinValueInUSD = '?';
  //
  // void getData() async{
  //
  //   try{
  //     double data = await CoinData().getCoinData();
  //
  //     setState(() {
  //       bitcoinValueInUSD = data.toStringAsFixed(0);
  //     });
  //
  //   }catch(e){
  //     print(e);
  //   }
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   getData();
  // }

  Map<String,String> coinValues = {};

  bool isWaiting = false;

  void getData() async{

    isWaiting = true;
    try{

      var data = await CoinData().getCoinData(selectedCurrency!);

      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    }catch(e){
      print(e);
    }

  }

  @override
  void initState() {
    super.initState();
    getData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker 🤑')),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              CryptoCard(value: isWaiting ? '?' : coinValues['BTC'] ?? '0.0', selectedCurrency: selectedCurrency!, cryptoCurrency: 'BTC'),
              CryptoCard(value: isWaiting ? '?' : coinValues['ETH'] ?? '0.0', selectedCurrency: selectedCurrency!, cryptoCurrency: 'ETH'),
              CryptoCard(value: isWaiting ? '?' : coinValues['LTC'] ?? '0.0', selectedCurrency: selectedCurrency!, cryptoCurrency: 'LTC'),

            ],
          ),

          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: iOSPicker() //Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
