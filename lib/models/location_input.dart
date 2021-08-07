import 'package:fav_places/helpers/location_helpers.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentLocation() async{
    final locData = await Location().getLocation();
    final staticMapImageURl = LocationHelper.getLocationPreviewImage(
        latitude: locData.latitude!, longitude: locData.longitude!);
    setState(() {
      _previewImageUrl = staticMapImageURl;
    });
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
            FlatButton.icon(onPressed: (){}
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
