import 'package:demo_12_03/Screen/AddFood/AddFood.dart';
import 'package:demo_12_03/Screen/AddOption/AddButton/AddButton.dart';
import 'package:demo_12_03/components/text_input_field.dart';
import 'package:demo_12_03/constants.dart';
import 'package:flutter/material.dart';

class Add_option extends StatelessWidget {
  final List<DanhMuc> danhmuc;
  const Add_option({Key? key, required this.danhmuc}) : super(key: key);
  void openDialog(context) {
    // await showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //           title: Text("dsadasd"),
    //         ));
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: Container(
                  width: size.width * 0.8,
                  height: size.width * 0.4,
                  // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(children: [
                    Text('Thêm danh mục'),
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
                                      borderSide:
                                          BorderSide(color: kPrimaryColor)))),
                        ),
                      ),
                    ),
                    Container(
                      // padding:
                      //     EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(children: [
                        Expanded(
                          child: RoundedButton(
                            hintText: "OK",
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                            child: RoundedButton(
                          hintText: "Cancel",
                          onPressed: () {},
                        ))
                      ]),
                    )
                  ])));
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? chooseOption = danhmuc.first.tenDMuc;
    return Scaffold(
        appBar: AppBar(
          title: Text("Thêm món ăn"),
          centerTitle: true,
          leading: BackButton(onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const AddFood()));
            Navigator.pop(context, '');
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
                Expanded(child: ChooseOption(danhmuc: danhmuc)),
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
                              onPressed: () => () {
                                    openDialog(context);
                                  }),
                        ),
                      ]),
                )
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
                  color: Color.fromARGB(255, 192, 190, 190),
                  style: BorderStyle.solid))),
        ),
        child: Text(hintText, style: TextStyle(color: kPrimaryLightColor)),
        onPressed: onPressed());
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
