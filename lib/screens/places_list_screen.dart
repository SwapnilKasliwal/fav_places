import 'package:fav_places/great_places.dart';
import 'package:fav_places/screens/add_place.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PlacesList extends StatelessWidget {

  static const id = 'PlacesList';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Places',),
        actions: <Widget>[
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, AddPlace.id);
              },
              icon: Icon(
                  Icons.add
                  )
              ),
        ],
      ),
      body: Consumer<GreatPlaces>(
        child: Center(
          child: const Text('Got no places yet, Start adding some!'),
        ),
        builder: (context, greatPlaces, child)=>
            greatPlaces.placesList.length<=0 ? child! :
            ListView.builder(itemCount: greatPlaces.placesList.length,
                itemBuilder: (context, index){
              return ListTile(leading: CircleAvatar(
                backgroundImage: FileImage(greatPlaces.placesList[index].image!),
              ),
                  title: Text(greatPlaces.placesList[index].title!),
                onTap: (){
                //Go to details Page
                },
                contentPadding: EdgeInsets.all(10),
              );
                })

      )
    );
  }
}
