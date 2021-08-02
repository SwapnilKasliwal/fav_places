import 'package:fav_places/great_places.dart';
import 'package:fav_places/screens/add_place.dart';
import 'package:flutter/material.dart';
import 'screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

      create: (context) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        routes: {
          PlacesList.id : (context) => PlacesList(),
          AddPlace.id : (context) => AddPlace(),
        },
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home : PlacesList(),
      ),
    );

  }
}