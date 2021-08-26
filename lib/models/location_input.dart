import 'package:fav_places/helpers/location_helpers.dart';
import 'package:fav_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:fav_places/screens/map_screen.dart';

class LocationInput extends StatefulWidget {

  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double long)
  {
    final staticMapImageURl = LocationHelper.getLocationPreviewImage(
        latitude: lat, longitude: long);
    setState(() {
      _previewImageUrl = staticMapImageURl;
    });

  }

  Future<void> _getCurrentLocation() async{
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude!, locData.longitude!);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    }
    catch(error)
    {
      return;
    }
  }
  Future<void> _selectOnMap() async{
    final locData = await Location().getLocation();
    final PlaceLocation inLocation = PlaceLocation(latitude: locData.latitude, longitude: locData.longitude);
    final LatLng selectedLocation = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context)=>MapScreen(initialLocation: inLocation,
            isSelecting: true,),
        fullscreenDialog: true,
        ));
    if(selectedLocation == null)
      return;
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null? Text(
              'No Location Provided',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ): Image.network(_previewImageUrl!,
            fit: BoxFit.cover,
            width: double.infinity,
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(onPressed: _getCurrentLocation
            , icon: Icon(Icons.location_on),
                label: Text('Current Location',
                style: TextStyle(color: Theme.of(context).primaryColor),
                ),
            ),
            FlatButton.icon(onPressed: _selectOnMap
              , icon: Icon(Icons.map),
              label: Text('Select on Map',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            )

          ],
        )
      ],
    );
  }
}
