import 'package:flutter/material.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key  key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child :Center(child: Text('Favourites' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 30),)) ,
    );
  }
}
