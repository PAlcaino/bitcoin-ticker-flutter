import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinInfoData extends StatelessWidget {
  const CoinInfoData({
    Key key,
    @required this.selectedCurrencyRate,
    @required this.coinName,
    @required this.selectedCurrency,
  }) : super(key: key);

  final String selectedCurrencyRate;
  final String selectedCurrency;
  final String coinName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $coinName = $selectedCurrencyRate $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
