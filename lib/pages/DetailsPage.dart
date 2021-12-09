import 'package:cryptotracker/models/Cryptocurrency.dart';
import 'package:cryptotracker/providers/ad_provider.dart';
import 'package:cryptotracker/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String id;

  const DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<AdProvider>(context, listen: false).initializeDetailsPageBanner();
    Provider.of<AdProvider>(context, listen: false).initializeFullPageAd();
  }

  Widget titleAndDetail(String title, String detail, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [

        Text(title, style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17
        ),),

        Text(detail, style: TextStyle(
          fontSize: 17
        ),),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AdProvider adProvider = Provider.of<AdProvider>(context, listen: false);

        if(adProvider.isFullPageAdLoaded) {
          adProvider.fullPageAd.show();
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Consumer<MarketProvider>(
              builder: (context, marketProvider, child) {

                CryptoCurrency currentCrypto = marketProvider.fetchCryptoById(widget.id);

                return RefreshIndicator(
                  onRefresh: () async {
                    await marketProvider.fetchData();
                  },
                  child: ListView(
                    physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()
                    ),
                    children: [

                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(currentCrypto.image!),
                        ),
                        title: Text(currentCrypto.name! + " (${currentCrypto.symbol!.toUpperCase()})", style: TextStyle(
                          fontSize: 20,
                        ),),
                        subtitle: Text("₹ " + currentCrypto.currentPrice!.toStringAsFixed(4), style: TextStyle(
                          color: Color(0xff0395eb),
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),),
                      ),

                      SizedBox(height: 20,),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text("Price Change (24h)", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),),

                          Builder(
                            builder: (context) {
                              double priceChange = currentCrypto.priceChange24!;
                              double priceChangePercentage = currentCrypto.priceChangePercentage24!;

                              if(priceChange < 0) {
                                // negative
                                return Text("${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})", style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 23
                                ),);
                              }
                              else {
                                // positive
                                return Text("+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})", style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 23
                                ),);
                              }
                            },
                          ),

                        ],
                      ),


                      SizedBox(height: 30,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          titleAndDetail("Market Cap", "₹ " + currentCrypto.marketCap!.toStringAsFixed(4), CrossAxisAlignment.start),

                          titleAndDetail("Market Cap Rank", "#" + currentCrypto.marketCapRank.toString(), CrossAxisAlignment.end),

                        ],
                      ),

                      SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          titleAndDetail("Low 24h", "₹ " + currentCrypto.low24!.toStringAsFixed(4), CrossAxisAlignment.start),

                          titleAndDetail("High 24h", "₹ " + currentCrypto.high24!.toStringAsFixed(4), CrossAxisAlignment.end),

                        ],
                      ),

                      SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          titleAndDetail("Circulating Supply", currentCrypto.circulatingSupply!.toInt().toString(), CrossAxisAlignment.start),

                        ],
                      ),

                      SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          titleAndDetail("All Time Low", currentCrypto.atl!.toStringAsFixed(4), CrossAxisAlignment.start),

                          titleAndDetail("All Time High", currentCrypto.ath!.toStringAsFixed(4), CrossAxisAlignment.start),

                        ],
                      ),

                    ],
                  ),
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: Consumer<AdProvider>(
          builder: (context, adProvider, child) {

            if(adProvider.isDetailsBannerLoaded == true) {
              return Container(
                height: adProvider.detailsBanner.size.height.toDouble(),
                child: AdWidget(ad: adProvider.detailsBanner,),
              );
            }
            else {
              return Container(
                height: 0,
                child: Container(),
              );
            }

          },
        ),
      ),
    );
  }
}