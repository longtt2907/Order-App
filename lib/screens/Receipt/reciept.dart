import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/controllers/bill_controller.dart';
import 'package:demo_12_03/models/bill_model.dart';
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
              // Expanded(
              //   child: Container(
              //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              //     color: Colors.white,
              //     child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           const Text(
              //             "Sắp xếp",
              //             style: TextStyle(
              //               fontSize: 18,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.black,
              //             ),
              //           ),
              //           DropDownList(
              //             items: ['Ngày', 'Giá'],
              //             itemChoosed: _item,
              //             onChanged: (val) {
              //               setState(() {
              //                 _item = val!;
              //               });
              //             },
              //           ),
              //         ]),
              //   ),
              // ),
              Container(
                  height: size.height * 0.87,
                  color: Colors.white,
                  child: FutureBuilder(
                      future: BillService().getBills(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Bill>> snapshot) {
                        if (snapshot.hasData) {
                          List<Bill> bills = snapshot.data!;
                          return ListView.builder(
                            itemCount: bills.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  padding: EdgeInsets.all(15),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // "Mã Hóa Đơn:${bills[index].id}",
                                            "Mã Hóa Đơn:${index}",
                                            softWrap: true,
                                          ),
                                          const SizedBox(height: 10),
                                          bills[bills.length - index - 1]
                                                      .status ==
                                                  true
                                              ? Row(
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .check_circle_rounded,
                                                        color: Colors.green),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Paid",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    Icon(Icons.cancel_rounded,
                                                        color: Colors.red),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Unpay",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  ],
                                                )
                                        ],
                                      ),
                                      Text(
                                        "${numFormat.format(bills[bills.length - index - 1].total)}đ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ));
                            },
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      }))
            ],
          )),
    );
  }
}
