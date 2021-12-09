import 'package:cryptotracker/constants/Themes.dart';
import 'package:cryptotracker/providers/ad_provider.dart';
import 'package:cryptotracker/services/LocalStorage.dart';
import 'package:cryptotracker/pages/HomePage.dart';
import 'package:cryptotracker/providers/market_provider.dart';
import 'package:cryptotracker/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  String currentTheme = await LocalStorage.getTheme() ?? "light";

  runApp(MyApp(
    theme: currentTheme,
  ));
}

class MyApp extends StatelessWidget {

  final String theme;

  MyApp({required this.theme});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
          create: (context) => MarketProvider(),
        ),

        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(theme),
        ),

        ChangeNotifierProvider<AdProvider>(
          create: (context) => AdProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: HomePage(),
          );

        },
      ), 
    );
  }
}