import 'package:demo_12_03/controllers/bill_controller.dart';
import 'package:demo_12_03/models/bill_model.dart';
import "package:flutter/material.dart";

import '../../../constants.dart';

class TableOrder extends StatelessWidget {
  const TableOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 15);
    return Container(
        padding: EdgeInsets.all(20),
        child: FutureBuilder(
            future: BillService().getBills(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Bill>> snapshot) {
              if (snapshot.hasData) {
                List<Bill> bills = [];
                bills = snapshot.data!;

                return GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                    ),
                    children: bills
                        .where((bill) => bill.status == false)
                        .map(
                          (bill) => Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(children: [
                              Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                  color: Colors.blue,
                                ),
                                padding: padding,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Table 1"),
                                    Text("${numFormat.format(bill.total)}đ "),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Ink(
                                  padding: padding,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                    color: kPrimaryColor,
                                  ),
                                ),
                              )
                            ]),
                          ),
                        )
                        .toList());
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
