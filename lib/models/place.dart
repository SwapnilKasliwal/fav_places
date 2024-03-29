import 'dart:io';
import 'package:flutter/foundation.dart';
class Place{

  final String? id;
  final String? title;
  final File? image;
  final PlaceLocation? location;

  Place({@required this.id, @required this.title, @required this.image, @required this.location});
}

class PlaceLocation{
  final double? latitude;
  final double? longitude;
  final String? address;

  const PlaceLocation({@required this.latitude, @required this.longitude, this.address});

}