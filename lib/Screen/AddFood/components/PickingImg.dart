import 'dart:io';
import "package:image_picker/image_picker.dart";
import "package:flutter/material.dart";

class PickingImg extends StatefulWidget {
  const PickingImg({Key? key}) : super(key: key);

  @override
  State<PickingImg> createState() => _PickingImgState();
}

class _PickingImgState extends State<PickingImg> {
  File? _image;
  _imgFromCamera() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image == null) {
      _image = null;
      return;
    }
    setState(() {
      _image = File(image.path);
    });
  }

  void _imgFromGallery() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image == null) return;
    setState(() {
      _image = File(image.path);
    });
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
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 199, 198, 198),
              ),
              // radius: 55,
              // backgroundColor: Color(0xffFDCF09),
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        _image!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : Container(
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
