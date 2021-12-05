import 'package:cryptotracker/models/Cryptocurrency.dart';
import 'package:cryptotracker/pages/DetailsPage.dart';
import 'package:cryptotracker/providers/market_provider.dart';
import 'package:cryptotracker/widgets/CryptoListTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Markets extends StatefulWidget {
  const Markets({ Key? key }) : super(key: key);

  @override
  _MarketsState createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if(marketProvider.isLoading == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else {
          if(marketProvider.markets.length > 0) {
            return RefreshIndicator(
              onRefresh: () async {
                await marketProvider.fetchData();
              },
              child: ListView.builder(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()
                ),
                itemCount: marketProvider.markets.length,
                itemBuilder: (context, index) {
                  CryptoCurrency currentCrypto = marketProvider.markets[index];

                  return CryptoListTile(currentCrypto: currentCrypto);
                },
              ),
            );
          }
          else {
            return Text("Data not found!");
          }
        }
      },
    );
  }
}