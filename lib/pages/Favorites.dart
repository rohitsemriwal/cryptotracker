import 'package:cryptotracker/models/Cryptocurrency.dart';
import 'package:cryptotracker/providers/market_provider.dart';
import 'package:cryptotracker/widgets/CryptoListTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({ Key? key }) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {

        List<CryptoCurrency> favorites = marketProvider.markets.where((element) => element.isFavorite == true).toList();

        if(favorites.length > 0) {
          return RefreshIndicator(
            onRefresh: () async {
              await marketProvider.fetchData();
            },
            child: ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {

                CryptoCurrency currentCrypto = favorites[index];
                return CryptoListTile(currentCrypto: currentCrypto);

              },
            ),
          );
        }
        else {
          return Center(
            child: Text("No favorites yet", style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),),
          );
        }
        

      },
    );
    // return Container(
    //   child: Text("Favorites will show up here"),
    // );
  }
}