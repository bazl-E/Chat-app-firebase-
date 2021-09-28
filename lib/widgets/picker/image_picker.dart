import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickers extends StatefulWidget {
  ImagePickers(this.setImage, {Key? key}) : super(key: key);
  final void Function(XFile image) setImage;

  @override
  _ImagePickersState createState() => _ImagePickersState();
}

class _ImagePickersState extends State<ImagePickers> {
  // File? image;
  XFile? image;
  void _pickImage() async {
    final _imagePicker = ImagePicker();
    final pickedimage = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedimage == null) {
      return;
    }
    image = pickedimage;
    setState(() {
      image = pickedimage;
    });
    widget.setImage(image!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Theme.of(context).primaryColor,
          backgroundImage: image == null
              ? null
              : FileImage(
                  File(image!.path),
                ),
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text(
            'pic a profile pic',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
