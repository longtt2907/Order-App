// ignore_for_file: prefer_const_constructors

import 'package:demo_12_03/Screen/AddOption/Add_options.dart';
import 'package:demo_12_03/Screen/AddFood/components/PickingImg.dart';
import 'package:demo_12_03/components/input_container.dart';
import 'package:demo_12_03/components/round_button.dart';
import 'package:demo_12_03/components/text_input_field.dart';
import 'package:demo_12_03/constants.dart';
import "package:flutter/material.dart";

class AddFood extends StatelessWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Thêm món ăn"),
          centerTitle: true,
          leading: BackButton(
              color: Colors.white, onPressed: () => {Navigator.pop(context)}),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
          backgroundColor: kPrimaryColor,
          elevation: 4,
        ),
        body: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: size.height),
          child: Center(
            child: Expanded(
              child: InfoContainer(),
            ),
          ),
        ));
  }
}

class TapInputField extends StatelessWidget {
  final String? value;
  final String? hintText;
  final Function onTap;
  const TapInputField({
    Key? key,
    this.value,
    this.hintText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: (value) {},
        onTap: onTap(),
        decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            suffixIcon: Icon(Icons.arrow_circle_right, color: kPrimaryColor)));
  }
}

class DanhMuc {
  final String? tenDMuc;
  const DanhMuc({this.tenDMuc});
}

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    Key? key,
  }) : super(key: key);

  void pageBuilder(BuildContext context, List<DanhMuc> danhmuc) async {
    await Future.delayed(Duration.zero, () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Add_option(danhmuc: danhmuc)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DanhMuc> danhmuc = [
      DanhMuc(tenDMuc: "tra sua"),
      DanhMuc(tenDMuc: "tra kem chese"),
      DanhMuc(tenDMuc: "topping")
    ];
    Size size = MediaQuery.of(context).size;
    return Container(
        width: double.infinity,
        height: size.height,
        color: Color.fromARGB(255, 190, 188, 188),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  PickingImg(),
                  Text("Nhấp vào để chọn hình ảnh"),
                  InputContainer(
                      child: RoundedInputField(
                          hintText: 'Món ăn', icon: Icons.local_drink)),
                  InputContainer(
                      child: RoundedInputField(
                          hintText: 'Giá', icon: Icons.price_check)),
                ],
              ),
            ),
            Container(
                color: Colors.white,
                width: double.infinity,
                // padding: EdgeInsets.symmetric(vertical: 10),
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(children: [
                  const SizedBox(height: 10),
                  Text("Danh mục", style: TextStyle(fontSize: 17)),
                  InputContainer(
                    child: TapInputField(
                        hintText: "Danh mục",
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const Add_option()),
                          // );
                        }),
                  ),
                  InputContainer(
                    child: TapInputField(
                        hintText: "Đơn vị",
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const Add_option()),
                          // );
                        }),
                  ),
                  // InputContainer(
                  //   child: TapInputField(
                  //       hintText: "Đơn vị",
                  //       onTap: () => () {
                  //             pageBuilder(context, danhmuc);
                  //           }),
                  // ),
                ])),
            Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Liên kết kho"),
                        Switch(
                          onChanged: (val) {},
                          value: true,
                          inactiveThumbColor: kPrimaryTextColor,
                          inactiveTrackColor: kPrimaryColor,
                          activeColor: kPrimaryColor,
                        )
                      ],
                    ),
                    //SwitchEnable
                    InputContainer(
                      child: TapInputField(
                          hintText: "Danh mục",
                          onTap: () => () {
                                pageBuilder(context, danhmuc);
                              }),
                    ),
                  ],
                )),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: size.width * 0.2,
              child: RoundButton(
                  text: 'Thêm món ăn',
                  color: kPrimaryColor,
                  textColor: Colors.white,
                  press: () {}),
            ),
          ]),
        ));
  }
}
