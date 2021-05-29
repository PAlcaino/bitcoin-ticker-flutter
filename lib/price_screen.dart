import 'dart:io' show Platform;

import 'package:bitcoin_ticker/services/coin_data.dart';
import 'package:bitcoin_ticker/widgets/coin_data_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  var coinRateMap = new Map();
  bool isWaiting = false;

  DropdownButton getAndroidDropdown() {
    List<DropdownMenuItem<String>> menuDropDownItems = [];
    for (String currency in currenciesList) {
      menuDropDownItems.add(
        DropdownMenuItem(
          value: currency,
          child: Text(currency),
        ),
      );
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: menuDropDownItems,
      onChanged: (value) {
        print(value);
        setState(() {
          selectedCurrency = value;
          getCoinData(selectedCurrency);
        });
      },
    );
  }

  CupertinoPicker getIOSPicker() {
    List<Text> menuTextItems = [];
    for (String currency in currenciesList) {
      menuTextItems.add(Text(currency));
    }

    return CupertinoPicker(
      children: menuTextItems,
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCurrency = menuTextItems[index].data;
          getCoinData(selectedCurrency);
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getCoinData(selectedCurrency);
  }

  void getCoinData(String selectedCurrency) async {
    isWaiting = true;
    var tempMap = new Map();
    for (String coin in cryptoList) {
      dynamic data =
          await CoinData().getCoinDataByCurrency(coin, selectedCurrency);

      double rate = data['rate'];
      tempMap[coin] = rate.toInt();
    }
    isWaiting = false;
    setState(() {
      coinRateMap = tempMap;
      print(coinRateMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (String coin in cryptoList)
            CoinInfoData(
              coinName: coin,
              selectedCurrency: selectedCurrency,
              selectedCurrencyRate:
                  isWaiting ? '?' : coinRateMap[coin].toString(),
            ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: !Platform.isAndroid ? getAndroidDropdown() : getIOSPicker(),
          ),
        ],
      ),
    );
  }
}
