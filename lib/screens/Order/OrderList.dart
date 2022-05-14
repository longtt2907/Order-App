import 'dart:developer';

import 'package:demo_12_03/components/dotted_divider.dart';
import 'package:demo_12_03/constants.dart';
import "package:flutter/material.dart";

import '../../models/bill_model.dart';
import 'Order.dart';

class OrderList extends StatefulWidget {
  OrderList({Key? key, required this.bill}) : super(key: key);

  late Bill bill;

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  void handleDeleteBill() {
    // setState(() {
    //   widget.bill = null;
    // });S
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Order(),
    ));
  }

  void NavigateToOrderPage(Bill bill) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Order(bill: bill),
    ));
  }

  void handleDelete(Dish dish) {
    setState(() {
      widget.bill.dishes.remove(dish);
      widget.bill.totalPrice = widget.bill.totalPrice! - dish.totalPrice;
      widget.bill.total = widget.bill.total! - dish.quantity;
    });
    if (widget.bill.total == 0) ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        leading: BackButton(
            color: Colors.black,
            onPressed: () => NavigateToOrderPage(widget.bill)),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // padding: EdgeInsets.all(20),
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 120),
        child: Column(
          children: [
            Container(
              height: 50,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          children: widget.bill.dishes
                              .map((dish) => Dismissible(
                                    key: Key(dish.dish.title),
                                    background: Container(
                                      color: Colors.red,
                                      height: 90,
                                    ),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (DismissDirection direction) {
                                      handleDelete(dish);
                                    },
                                    child: ItemList(
                                        bill: widget.bill,
                                        dish: dish,
                                        onChanged: (val) {
                                          setState(() {});
                                        }),
                                  ))
                              .toList()),
                    ),
                    Container(
                      // height: 60,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tạm tính:  ",
                              style: TextStyle(
                                  fontSize: 17,
                                  // fontWeight: FontWeight.bold,
                                  color: kBackgroundColor)),
                          Text("${widget.bill.totalPrice}đ ",
                              style: TextStyle(
                                  fontSize: 17, // fontWeight: FontWeight.bold,
                                  color: kBackgroundColor)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container()
          ],
        ),
      ),
      bottomSheet: Container(
        // height: size.height * 0.25,
        height: 120,
        child: Column(children: [
          Container(
            width: double.infinity,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(color: kPrimaryColor.withOpacity(0.3)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tổng tiền: ",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("${widget.bill.totalPrice}đ",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
              height: 70,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: OrderListButton(
                      title: "Xóa",
                      color: Colors.greenAccent,
                      onPressed: () => handleDeleteBill(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: OrderListButton(
                      title: "Lưu",
                      color: Colors.blue,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: OrderListButton(
                      title: "Hoàn tất",
                      color: kPrimaryColor,
                      onPressed: () {},
                    ),
                  ),
                ],
              ))
        ]),
      ),
    );
  }
}

class OrderListButton extends StatelessWidget {
  const OrderListButton({
    Key? key,
    this.title,
    this.color,
    required this.onPressed,
  }) : super(key: key);

  final String? title;
  final Color? color;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color!),
            minimumSize: MaterialStateProperty.all(Size(50, 200)),
          ),
          child: Text("${title}",
              style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: onPressed),
    );
  }
}

class ItemList extends StatefulWidget {
  ItemList({
    Key? key,
    required this.dish,
    required this.onChanged,
    required this.bill,
  }) : super(key: key);

  final Function(Dish) onChanged;
  late Dish dish;
  late Bill bill;

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List<Widget> buildList() {
    List<Widget> list = [Text('${widget.dish.size}')];
    widget.dish.subDish!
        .map((subDish) => list.add(Text("${subDish.title}")))
        .toList();
    return list;
  }

  void subtract() {
    if (widget.dish.quantity > 1) {
      setState(() {
        int price = (widget.dish.totalPrice / widget.dish.quantity) as int;
        widget.dish.quantity = --widget.dish.quantity;
        widget.dish.totalPrice = price * widget.dish.quantity;
        widget.bill.totalPrice = widget.bill.totalPrice! - price;
        widget.bill.total = widget.bill.total! - 1;
        widget.onChanged(widget.dish);
      });
    }
  }

  void add() {
    setState(() {
      int price = (widget.dish.totalPrice / widget.dish.quantity) as int;
      widget.dish.quantity = ++widget.dish.quantity;
      widget.dish.totalPrice = price * widget.dish.quantity;
      widget.bill.totalPrice = widget.bill.totalPrice! + price;
      widget.bill.total = widget.bill.total! + 1;
      widget.onChanged(widget.dish);
    });
    // widget.onChanged(i);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 90,
        maxHeight: 140,
      ),
      // height: 100,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${widget.dish.dish.title}",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )),
              Text("${widget.dish.totalPrice}đ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildList(),
                ),
              ),
              Container(
                height: 70,
                // alignment: Alignment.center,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.black,
                          )),
                          child:
                              Text("-", style: TextStyle(color: Colors.white)),
                          onPressed: () => subtract(),
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                  style: BorderStyle.solid)),
                          child: Text("${widget.dish.quantity}",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black)),
                          child:
                              Text("+", style: TextStyle(color: Colors.white)),
                          onPressed: () => add(),
                        ),
                      ),
                      // TextField(
                      //   keyboardType: TextInputType.number,
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // dish.note!.isEmpty
          //     ? const SizedBox(height: 0)
          //     : Container(
          //         alignment: Alignment.centerLeft,
          //         padding: EdgeInsets.all(10),
          //         margin: EdgeInsets.only(left: 10),
          //         child: Row(
          //           children: [
          //             Icon(Icons.note),
          //             const SizedBox(height: 10),
          //             Text(
          //               "${dish.note}",
          //               softWrap: true,
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //           ],
          //         ),
          //       ),
          Expanded(
              child:
                  Dash(length: size.width - 40, dashColor: kBackgroundColor)),
          // Divider(thickness: 1.0),
        ],
      ),
    );
  }
}
