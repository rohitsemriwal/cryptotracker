import 'package:cryptotracker/models/Cryptocurrency.dart';
import 'package:cryptotracker/pages/DetailsPage.dart';
import 'package:cryptotracker/pages/Favorites.dart';
import 'package:cryptotracker/pages/Markets.dart';
import 'package:cryptotracker/providers/ad_provider.dart';
import 'package:cryptotracker/providers/market_provider.dart';
import 'package:cryptotracker/providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  late TabController viewController;

  @override
  void initState() {
    super.initState();
    viewController = TabController(length: 2, vsync: this);
    Provider.of<AdProvider>(context, listen: false).initializeHomePageBanner();
  }

  @override
  Widget build(BuildContext context) {

    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 0
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Welcome Back", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Crypto Today", style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),),

                  IconButton(
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                    padding: EdgeInsets.all(0),
                    icon: (themeProvider.themeMode == ThemeMode.light) ? Icon(Icons.dark_mode) : Icon(Icons.light_mode),
                  ),
                ],
              ),

              TabBar(
                controller: viewController,
                tabs: [

                  Tab(
                    child: Text("Markets", style: Theme.of(context).textTheme.bodyText1,),
                  ),

                  Tab(
                    child: Text("Favorites", style: Theme.of(context).textTheme.bodyText1,),
                  ),

                ],
              ),

              Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()
                  ),
                  controller: viewController,
                  children: [

                    Markets(),

                    Favorites(),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Consumer<AdProvider>(
        builder: (context, adProvider, child) {

          if(adProvider.isHomeBannerLoaded == true) {
            return Container(
              height: adProvider.homePageBanner.size.height.toDouble(),
              child: AdWidget(ad: adProvider.homePageBanner,),
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
    );
  }
}