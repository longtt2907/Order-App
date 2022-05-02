import 'dart:io';
import "package:image_picker/image_picker.dart";
import "package:flutter/material.dart";
import 'package:cloudinary_public/cloudinary_public.dart';

final cloudinary = CloudinaryPublic('santaclaus', 'dpfzjfpa', cache: false);

class PickingImg extends StatefulWidget {
  final String? image;
  final Function(String) callback;
  const PickingImg({Key? key, this.image, required this.callback})
      : super(key: key);

  @override
  State<PickingImg> createState() => _PickingImgState();
}

class _PickingImgState extends State<PickingImg> {
  String? _image;
  // String? get imageUrl => _image;
  String? imageUrl() {
    return _image;
  }

  _imgFromCamera() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image == null) {
      _image = null;
      return;
    }
    setState(() {
      _image = image.path;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.image != null) {
      _image = widget.image;
    }
  }

  void _imgFromGallery() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image == null) {
      return;
    } else {
      try {
        CloudinaryResponse response = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(image.path,
                resourceType: CloudinaryResourceType.Image));

        widget.callback(response.secureUrl);
        setState(() {
          _image = response.secureUrl;
        });
      } on CloudinaryException catch (e) {
        print(e.message);
      }
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: GestureDetector(
            onTap: () {
              _showPicker(context);
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        _image!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox(
                      width: size.width * 0.3,
                      height: size.width * 0.3,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                        size: 30,
                      ),
                    ),
            ),
          ),
        ));
  }
}
