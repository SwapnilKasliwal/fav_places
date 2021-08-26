import 'package:fav_places/great_places.dart';
import 'package:fav_places/models/image_input.dart';
import 'package:fav_places/models/location_input.dart';
import 'package:fav_places/models/place.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '';
class AddPlace extends StatefulWidget {

  static const id = 'AddPlace';
  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _priceFocusNode = FocusNode();
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  void _selectedImage(File pickedImage){
    _pickedImage = pickedImage;
  }
  void _selectedPlace(double lat, double long)
  {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: long);
  }

  void _savePlace(){
    if(_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null)
      {
        return;
      }
    else{
     Provider.of<GreatPlaces>(context, listen: false).addPlace(_titleController.text, _pickedImage!, _pickedLocation!);
     Navigator.pop(context);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Column(
                  children: <Widget> [
                      Container(
                        width: 350,
                        child: TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'Title',
                            hintText: 'Enter the place name',
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            labelStyle: TextStyle(
                              fontSize: 20,
                                color: Colors.black,
                            ),
                            alignLabelWithHint: true,
                          ),
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_){
                            FocusScope.of(context).requestFocus(_priceFocusNode);
                          },
                          textAlign: TextAlign.center,
                        ),
                      ),
                    SizedBox(
                      height: 40,
                    ),
                    ImageInput(_selectedImage),

                    SizedBox(height: 10,),
                    LocationInput(_selectedPlace),

                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
              onPressed: _savePlace,
              icon: Icon(
                Icons.add
              ),
              padding: EdgeInsets.all(15),
              label: Text(
                'Add Place',
                style: TextStyle(
                  fontSize: 18
                ),
              ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }
}
