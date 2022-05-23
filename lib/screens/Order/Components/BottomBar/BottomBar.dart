import 'package:demo_12_03/models/product_model.dart';
import 'package:demo_12_03/screens/Order/OrderList.dart';
import 'package:demo_12_03/constants.dart';
import "package:flutter/material.dart";

import 'package:demo_12_03/models/bill_model.dart';

class BottomContainer extends StatefulWidget {
  const BottomContainer({
    Key? key,
    required this.size,
    this.bill,
  }) : super(key: key);

  final Size size;
  final Bill? bill;

  @override
  State<BottomContainer> createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  bool openBar = false;

  void handleOpenBar() {
    setState(() {
      openBar = !openBar;
    });
  }

  void buildPageOrderList(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => OrderList(bill: widget.bill!)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: openBar ? 350 : 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black.withOpacity(0.7),
                  width: 0.8,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            width: double.infinity,
            height: 30,
            child: GestureDetector(
                child: Icon(Icons.arrow_drop_up_rounded),
                onTap: () => handleOpenBar()),
          ),
          openBar
              ? Text("Sản phẩm",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
              : const SizedBox(height: 0),
          openBar
              ? Container(
                  height: 180,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return ItemList(product: widget.bill!.dishes[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(thickness: 1.0),
                      itemCount: widget.bill!.dishes!.length),
                )
              : const SizedBox(height: 0),
          ConfirmRow(
              bill: widget.bill,
              size: widget.size,
              onPressed: () => buildPageOrderList(context))
        ],
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Dish product;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        width: double.infinity,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Text("${product.dish.title}",
                    style: TextStyle(color: Colors.black, fontSize: 18)),
              ),
              Expanded(
                  flex: 1,
                  child: Text("${product.quantity}",
                      style: TextStyle(color: Colors.black, fontSize: 18))),
              Text("${product.totalPrice}đ",
                  style: TextStyle(color: Colors.black, fontSize: 18)),
            ]));
  }
}

class ConfirmRow extends StatelessWidget {
  const ConfirmRow(
      {Key? key,
      required this.bill,
      required this.size,
      required this.onPressed})
      : super(key: key);

  final Bill? bill;
  final Size size;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
              color: Colors.black.withOpacity(0.7),
              style: BorderStyle.solid,
              width: 0.8),
        ),
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
                    fontSize: 20,
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
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  onPressed: onPressed),
            ),
          ),
        ],
      ),
    );
  }
}
