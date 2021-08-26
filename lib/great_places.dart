import 'dart:collection';
import 'dart:io';
import 'package:fav_places/models/place.dart';
import 'package:flutter/foundation.dart';
import 'helpers/dbHelper.dart';
import 'models/place.dart';
import 'helpers/location_helpers.dart';

class GreatPlaces with ChangeNotifier{

  List<Place> _placesList = [];

  UnmodifiableListView<Place> get placesList{
    return UnmodifiableListView(_placesList);
  }
  Place findById(String id){
    return _placesList.firstWhere((place) => place.id==id);
  }
  Future<void> addPlace(String pickedTitle, File pickedImage, PlaceLocation pickedLocation) async{

    final address = await LocationHelper.getPlaceAddress(pickedLocation.latitude!, pickedLocation.longitude!);
    final updatedLocation = PlaceLocation(latitude: pickedLocation.latitude, longitude: pickedLocation.longitude, address: address);

    final newPlace = Place(id: DateTime.now().toString(),
        title: pickedTitle,
        image: pickedImage,
        location: updatedLocation);

    _placesList.add(newPlace);

    notifyListeners();

    DbHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image' : newPlace.image!.path,
      'loc_lat' : newPlace.location!.latitude,
      'loc_long' : newPlace.location!.longitude,
      'address' : newPlace.location!.address,
    }
    );
  }

  Future<void> readAndFetchData() async{
    final dataList = await DbHelper.getData('user_places');
    _placesList = dataList.map((item) => Place(
      id: item['id'],
        title: item['title'],
        image: File(item['image'],),
        location: PlaceLocation(latitude: item['loc_lat'], longitude: item['loc_long'], address: item['address'],)
    )).toList();

    notifyListeners();
  }

  void deletePlace(Place place){
    _placesList.remove(place);
    notifyListeners();
    DbHelper.delete('user_places', place.id!);
  }

}