import 'package:demo_12_03/constants.dart';
import "package:flutter/material.dart";

import '../models/product_model.dart';

class ChooseOption extends StatefulWidget {
  final List<dynamic> items;
  final Function(dynamic) onChanged;
  const ChooseOption({Key? key, required this.items, required this.onChanged})
      : super(key: key);

  @override
  State<ChooseOption> createState() => _ChooseOptionState();
}

class _ChooseOptionState extends State<ChooseOption> {
  dynamic id;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: widget.items
          .map((data) => RadioListTile<dynamic>(
              contentPadding: EdgeInsets.all(0),
              activeColor: kPrimaryColor,
              // title: Text("${data}",
              //     style: TextStyle(fontSize: size.width * 0.05)),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${data.title}",
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                      ),
                    ),
                    Text(
                      "${data.price}đ",
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                      ),
                    ),
                  ]),
              groupValue: id,
              value: data,
              onChanged: (val) {
                setState(() {
                  id = val;
                  //lưu để xác nhận
                });
                widget.onChanged(val);
              }))
          .toList(),
    );
  }
}
