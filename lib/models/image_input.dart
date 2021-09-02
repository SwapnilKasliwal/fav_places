import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;

class ImageInput extends StatefulWidget {

  final Function onSelectedImage;
  ImageInput(this.onSelectedImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async{
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.camera, maxWidth: 600,);
    setState(() {
      _storedImage = File(imageFile!.path);
    });
    final appDir = await sysPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile!.path);
    final savedImage = await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectedImage(savedImage);
  }
  Future<void> _choosePicture() async{
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery, maxWidth: 600,);
    setState(() {
      _storedImage = File(imageFile!.path);
    });
    final appDir = await sysPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile!.path);
    final savedImage = await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectedImage(savedImage);
  }
  @override
  Widget build(BuildContext context) {
    return Row(
        children: <Widget>[
        Container(
        height: 150,
        width: 150,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey)
        ),
        child: _storedImage != null ? Image.file(
          _storedImage!,
          fit: BoxFit.cover,
          width: double.infinity,) :
        Text('No Image Provided',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey
        ),)
    ),
    Expanded(child: Column(
    children: <Widget>[
      FlatButton.icon(onPressed: _takePicture,
        icon: Icon(
      Icons.camera
      ),
      label: Text('Capture Image',
      style: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
      ),
      ),
      SizedBox(
        height: 10,
      ),
      FlatButton.icon(onPressed: _choosePicture,
        icon: Icon(
            Icons.photo,
        ),
        label: Text('Choose From Gallery',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),),
      ),
    ],
    ),
    ),
    ],
    );
  }
}
