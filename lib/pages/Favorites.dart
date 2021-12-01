import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  const Favorites({ Key? key }) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Text("Favorites will show up here"),
      ),
    );
  }
}