import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'fetching_overlay.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';
import 'crypto_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currency = 'USD';
  Map<String, double> prices = {};
  @override
  void initState() {
    super.initState();
    for (String crypto in cryptoList) {
      prices[crypto] = 0.0;
    }
    getPrices();
  }

  CupertinoPicker getIOSPicker() {
    List<DropdownMenuItem<String>> items = [];
    for (String currency in currenciesList) {
      items.add(DropdownMenuItem<String>(
        child: Text(currency),
        value: currency,
      ));
    }

    return CupertinoPicker(
      children: items,
      onSelectedItemChanged: (value) {
        setState(() {
          currency = currenciesList[value];
          getPrices();
        });
      },
    );
  }

  DropdownButton getAndroidDropDown() {
    List<DropdownMenuItem<String>> items = [];
    for (String currency in currenciesList) {
      items.add(DropdownMenuItem<String>(
        child: Text(currency),
        value: currency,
      ));
    }

    return DropdownButton(
      items: items,
      onChanged: (value) {
        setState(() {
          currency = value;
          getPrices();
        });
      },
      value: currency,
    );
  }

  void getPrices() async {
    context.loaderOverlay.show(widget: FetchingOverlay());
    var coin = CoinData();
    Map<String, double> localPrices = {};
    for (String crypto in cryptoList) {
      localPrices[crypto] = await coin.getData(currency, crypto);
    }
    setState(() {
      context.loaderOverlay.hide();
      prices = localPrices;
    });
  }

  List<Widget> getCryptoCards() {
    List<Widget> cryptos = [];
    for (String crypto in cryptoList) {
      cryptos.add(
        CryptoCard(
          currency: currency,
          crypto: crypto,
          prices: prices,
        ),
      );
    }
    return cryptos;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> columnChildren = getCryptoCards();
    columnChildren.add(
      Container(
        height: 150.0,
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 30.0),
        color: Colors.lightBlue,
        child: Platform.isIOS ? getIOSPicker() : getAndroidDropDown(),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: columnChildren,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
        backgroundColor: Colors.lightBlueAccent,
        elevation: 12.0,
        onPressed: () {
          setState(() {
            getPrices();
          });
        },
      ),
    );
  }
}
