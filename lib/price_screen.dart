import 'dart:io';

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Network.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCur = 'USD';
  String btcRate = '?';
  String ethRate = '?';

  DropdownButton<String> androidPicker() {
    return DropdownButton(
        items: getDropDownItems(),
        value: selectedCur,
        onChanged: (value) {
          setState(() {
            selectedCur = value;
          });
        });
  }

  List<DropdownMenuItem<String>> getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String cur = currenciesList[i];
      var newItem = DropdownMenuItem(
        child: Text(cur),
        value: cur,
      );
      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
        selectedCur = currenciesList[selectedIndex];
        double btcRawRate = await getRate('BTC', selectedCur);
        double ethRawRate = await getRate('ETH', selectedCur);
        setState(() {
          btcRate = btcRawRate.toInt().toString();
          ethRate = ethRawRate.toInt().toString();
        });
      },
      children: getPickerItems(),
    );
  }

  List<Text> getPickerItems() {
    List<Text> items = [];
    for (String cur in currenciesList) {
      var newItem = Text(
        cur,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
      items.add(newItem);
    }
    return items;
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
          Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $btcRate $selectedCur',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $ethRate $selectedCur',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}
