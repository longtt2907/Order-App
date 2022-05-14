import 'package:demo_12_03/screens/AddFood/AddFood.dart';
import 'package:demo_12_03/screens/AddOption/AddButton/AddButton.dart';
import 'package:demo_12_03/components/text_input_field.dart';
import 'package:demo_12_03/constants.dart';
import 'package:flutter/material.dart';

class Add_option extends StatefulWidget {
  final List<DanhMuc> danhmuc;
  const Add_option({Key? key, required this.danhmuc}) : super(key: key);

  @override
  State<Add_option> createState() => _Add_optionState();
}

class _Add_optionState extends State<Add_option> {
  void openDialog(context) async {
    // await showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //           title: Text("dsadasd"),
    //         ));
    setState(() {
      () => showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(title: Text("Thêm danh mục"), children: [
              RoundedInputField(hintText: "Thực đơn", icon: Icons.menu_book)
            ]);
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? chooseOption = widget.danhmuc.first.tenDMuc;
    return Scaffold(
        appBar: AppBar(
          title: Text("Thêm món ăn"),
          centerTitle: true,
          leading: BackButton(onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const AddFood()));
            Navigator.pop(context);
          }),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
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
                Expanded(child: ChooseOption(danhmuc: widget.danhmuc)),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: AddButton(
                              text: "Xác nhận",
                              color: kPrimaryColor,
                              onPressed: () {}),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5)),
                        Expanded(
                          child: AddButton(
                              text: "Tạo danh mục",
                              color: kPrimaryColor,
                              onPressed: () {
                                () => openDialog(context);
                              }),
                        ),
                      ]),
                )
              ],
            )));
  }
}

class ChooseOption extends StatefulWidget {
  final List<DanhMuc> danhmuc;
  const ChooseOption({Key? key, required this.danhmuc}) : super(key: key);

  @override
  State<ChooseOption> createState() => _ChooseOptionState();
}

class _ChooseOptionState extends State<ChooseOption> {
  DanhMuc? id;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: widget.danhmuc
          .map((data) => RadioListTile<DanhMuc>(
              activeColor: kPrimaryColor,
              title: Text("${data.tenDMuc}",
                  style: TextStyle(fontSize: size.width * 0.05)),
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
