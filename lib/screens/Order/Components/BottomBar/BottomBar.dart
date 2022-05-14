import 'package:demo_12_03/screens/Order/OrderList.dart';
import 'package:demo_12_03/constants.dart';
import "package:flutter/material.dart";

import "package:demo_12_03/models/bill_model.dart";

class BottomContainer extends StatelessWidget {
  const BottomContainer({
    Key? key,
    required this.size,
    this.bill,
  }) : super(key: key);

  final Size size;
  final Bill? bill;

  void buildPageOrderList(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => OrderList(bill: bill!)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 110,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: kBackgroundColor,
                  width: 1.0,
                  style: BorderStyle.solid)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tổng tiền: ${bill != null ? "${bill!.totalPrice}đ" : ''}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.025,
                    ),
                  ),
                  Text("Mặt hàng: ${bill != null ? bill!.total : ''}"),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kPrimaryColor),
                      minimumSize: MaterialStateProperty.all(
                          Size(size.width * 1, size.width * 0.2)),
                    ),
                    child: Text("Hoàn tất",
                        style: TextStyle(
                            color: Colors.white, fontSize: size.height * 0.02)),
                    onPressed: () => buildPageOrderList(context)),
              ),
            ),
          ],
        ));
  }
}
