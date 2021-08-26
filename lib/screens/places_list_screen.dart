import 'package:fav_places/great_places.dart';
import 'package:fav_places/screens/add_place.dart';
import 'package:fav_places/screens/place_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PlacesList extends StatelessWidget {

  static const id = 'PlacesList';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Places',),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, AddPlace.id);
      },
      backgroundColor: Colors.amber,
      child: Icon(
        Icons.add
      ),
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).readAndFetchData(),
          builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting?
              Center(child: CircularProgressIndicator(),
              ):
        Consumer<GreatPlaces>(
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
                  subtitle: Text(greatPlaces.placesList[index].location!.address!),
                  onTap: (){
                  Navigator.pushNamed(context, PlaceDetail.id,arguments: greatPlaces.placesList[index].id);
                  },
                  contentPadding: EdgeInsets.all(10),
                  onLongPress: (){
                  greatPlaces.deletePlace(greatPlaces.placesList[index]);
                  },
                );
                  })

        ),
      )
    );
  }
}
