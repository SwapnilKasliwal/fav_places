import 'dart:collection';
import 'dart:io';
import 'package:fav_places/models/place.dart';
import 'package:flutter/foundation.dart';

class GreatPlaces with ChangeNotifier{

  List<Place> _placesList = [];

  UnmodifiableListView<Place> get placesList{
    return UnmodifiableListView(_placesList);
  }
  void addPlace(String pickedTitle, File pickedImage){
    _placesList.add(
      Place(id: DateTime.now().toString(),
          title: pickedTitle,
          image: pickedImage,
          location: null)
    );
    notifyListeners();
  }

}