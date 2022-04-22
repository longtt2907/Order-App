import 'package:demo_12_03/constants.dart';
import "package:flutter/material.dart";

class ChooseOption extends StatefulWidget {
  final List<String> danhmuc;
  const ChooseOption({Key? key, required this.danhmuc}) : super(key: key);

  @override
  State<ChooseOption> createState() => _ChooseOptionState();
}

class _ChooseOptionState extends State<ChooseOption> {
  String? id;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: widget.danhmuc
          .map((data) => RadioListTile<String>(
              contentPadding: EdgeInsets.all(0),
              activeColor: kPrimaryColor,
              // title: Text("${data}",
              //     style: TextStyle(fontSize: size.width * 0.05)),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Size",
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                      ),
                    ),
                    Text(
                      "${data}",
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
              }))
          .toList(),
    );
  }
}
