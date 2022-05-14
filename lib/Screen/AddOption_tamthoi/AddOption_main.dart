import 'dart:developer';

import 'package:demo_12_03/Screen/AddFood/AddFood.dart';
import 'package:demo_12_03/Screen/AddOption_tamthoi/ChooseList.dart';
import 'package:demo_12_03/components/round_button.dart';
import 'package:demo_12_03/constants.dart';
import 'package:flutter/material.dart';

class AddOptionMain extends StatefulWidget {
  final List<String> danhmuc;
  const AddOptionMain({Key? key, required this.danhmuc}) : super(key: key);

  @override
  State<AddOptionMain> createState() => _AddOptionMainState();
}

class _AddOptionMainState extends State<AddOptionMain> {
  List<String> danhmucSelected = [];
  void themDanhMuc(String itemValue) {
    setState(() {
      widget.danhmuc.add(itemValue);
    });
    Navigator.pop(context);
  }

  void xoaDanhMuc(List<String> dm) {
    setState(() {
      for (int i = 0; i < dm.length; i++) {
        widget.danhmuc.remove(dm[i]);
      }
    });
  }

  void openDialog(context) {
    Size size = MediaQuery.of(context).size;
    String itemValue = '';
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: Container(
                  width: size.width * 0.8,
                  height: size.width * 0.4,
                  // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(children: [
                    const SizedBox(height: 15),
                    const Text(
                      'Thêm danh mục',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Color.fromARGB(162, 0, 0, 0),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        // height: size.width * 0.25,
                        // decoration: BoxDecoration(
                        //     border: Border.all(
                        //         color: kPrimaryColor,
                        //         width: 0.9,
                        //         style: BorderStyle.solid)),
                        child: Center(
                          child: TextField(
                            decoration: InputDecoration(
                              // alignLabelWithHint: true,
                              labelText: "Tên danh mục",
                              labelStyle: TextStyle(color: kPrimaryColor),
                              // hintText: "Tên danh mục",
                              focusColor: kPrimaryColor,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                              ),
                            ),
                            onChanged: (value) {
                              itemValue = value;
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      // padding:
                      //     EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(children: [
                        Expanded(
                          child: RoundedButton(
                            hintText: "OK",
                            onPressed: () => () {
                              themDanhMuc(itemValue);
                            },
                          ),
                        ),
                        Expanded(
                            child: RoundedButton(
                          hintText: "Cancel",
                          onPressed: () => () {
                            Navigator.pop(context);
                          },
                        ))
                      ]),
                    )
                  ])));
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? chooseOption = widget.danhmuc.first;
    return Scaffold(
        appBar: AppBar(
          title: Text("Thêm món ăn"),
          centerTitle: true,
          leading: BackButton(onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const AddFood()));
            Navigator.pop(context, widget.danhmuc);
          }),
          actions: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                xoaDanhMuc(danhmucSelected);
              },
            )
          ],
          backgroundColor: kPrimaryColor,
          elevation: 4,
        ),
        body: Container(
            width: double.infinity,
            height: size.height,
            child: Column(
              children: [
                // Expanded(
                //   child: MultiSelect(
                //     items: widget.danhmuc,
                //     selectedItems: danhmucSelected,
                //     onChanged: (items) {
                //       danhmucSelected = items;
                //     },
                //   ),
                // ),
                Container(
                  height: size.width * 0.2,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: RoundButton(
                      text: 'Thêm danh mục',
                      color: kPrimaryColor,
                      textColor: Colors.white,
                      press: () => () {
                            openDialog(context);
                          }),
                ),
              ],
            )));
  }
}

class RoundedButton extends StatelessWidget {
  final String hintText;
  final Function onPressed;
  const RoundedButton({
    Key? key,
    required this.hintText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
              Size(size.width * 0.8, size.width * 0.15)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              side: BorderSide(
                  color: Color.fromRGBO(192, 190, 190, 1),
                  style: BorderStyle.solid))),
        ),
        child: Text(hintText, style: TextStyle(color: kPrimaryLightColor)),
        onPressed: onPressed());
  }
}
