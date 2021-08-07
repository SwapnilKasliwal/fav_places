import 'dart:collection';
import 'dart:io';
import 'package:fav_places/models/place.dart';
import 'package:flutter/foundation.dart';
import 'helpers/dbHelper.dart';
import 'models/place.dart';

class GreatPlaces with ChangeNotifier{

  List<Place> _placesList = [];

  UnmodifiableListView<Place> get placesList{
    return UnmodifiableListView(_placesList);
  }
  void addPlace(String pickedTitle, File pickedImage){

    final newPlace = Place(id: DateTime.now().toString(),
        title: pickedTitle,
        image: pickedImage,
        location: null);

    _placesList.add(newPlace);

    notifyListeners();

    DbHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image' : newPlace.image!.path,
    }
    );
  }

  Future<void> readAndFetchData() async{
    final dataList = await DbHelper.getData('user_places');
    _placesList = dataList.map((item) => Place(
      id: item['id'],
        title: item['title'],
        image: File(item['image'],)
    )).toList();

    notifyListeners();
  }

}