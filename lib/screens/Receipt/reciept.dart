import 'package:demo_12_03/constants.dart';
import "package:flutter/material.dart";

import '../HomePage/Body/dropDownList.dart';

class ReceiptManage extends StatefulWidget {
  const ReceiptManage({Key? key}) : super(key: key);

  @override
  State<ReceiptManage> createState() => _ReceiptManageState();
}

class _ReceiptManageState extends State<ReceiptManage> {
  String _item = "Ngày";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Hóa Đơn"),
        centerTitle: true,
        leading: BackButton(onPressed: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const AddFood()));
          Navigator.pop(context);
        }),
        backgroundColor: kPrimaryColor,
        elevation: 4,
      ),
      body: Container(
          width: double.infinity,
          height: size.height,
          color: kPrimaryColor,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  color: Colors.white,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Sắp xếp",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        DropDownList(
                          items: [],
                          itemChoosed: _item,
                          onChanged: (val) {},
                        ),
                      ]),
                ),
              ),
              Container(
                height: size.height * 0.85,
                color: Colors.white,
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 0.8,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Mã Hóa Đơn: 11"),
                                Text("${DateTime.now()}"),
                              ],
                            ),
                            Text("100.000 VND")
                          ],
                        ));
                  },
                ),
              ),
            ],
          )),
    );
  }
}
