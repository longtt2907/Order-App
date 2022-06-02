import 'dart:developer';

import 'package:demo_12_03/components/dotted_divider.dart';
import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/controllers/bill_controller.dart';
import "package:flutter/material.dart";
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:demo_12_03/models/bill_model.dart';
import 'Order.dart';
import 'package:oktoast/oktoast.dart';

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

  void handleSubmit() {
    widget.bill.status = true;
    BillService().createbill(widget.bill).then((result) {
      log("${result}");
      handleDeleteBill();
    });

    Fluttertoast.showToast(
        msg: "Hoàn tất",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.green.withOpacity(0.8),
        textColor: Colors.white,
        webPosition: "center",
        fontSize: 16.0);
  }

  void handlePay(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 140,
              child: Column(children: [
                Container(
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFD82D8B)),
                            minimumSize:
                                MaterialStateProperty.all(Size(50, 200)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                width: 25,
                                height: 25,
                                image: NetworkImage(
                                    "https://res.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_170,w_170,f_auto,b_white,q_auto:eco,dpr_1/v1458245625/pwegh6kadcb37kuz0woj.png"),
                              ),
                              const SizedBox(width: 10),
                              Text("Thanh toán bằng momo",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                          onPressed: () => handleSubmit()),
                    )),
                const SizedBox(height: 20),
                Container(
                  height: 60,
                  child: OrderListButton(
                      title: "Thanh toán tiền mặt",
                      color: kBlackColor,
                      icon: Icons.payment,
                      onPressed: () => {
                            handleSubmit(),
                            Navigator.of(context, rootNavigator: true).pop()
                          }),
                )
                // Container(
                //     decoration:
                //         BoxDecoration(borderRadius: BorderRadius.circular(25)),
                //     child: TextButton(
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Icon(
                //               Icons.abc,
                //               color: Colors.black,
                //               size: 20,
                //             ),
                //             const SizedBox(width: 10),
                //             Text("gi do",
                //                 style: TextStyle(
                //                     color: Colors.white,
                //                     fontSize: 15,
                //                     fontWeight: FontWeight.w700)),
                //           ],
                //         ),
                //         onPressed: () {})),
              ]),
            ),
          );
        });
  }

  void handleSave() {
    widget.bill.status = false;
    BillService().createbill(widget.bill).then((result) {
      log("${result}");
      handleDeleteBill();
    });

    Fluttertoast.showToast(
        msg: "Lưu",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.green.withOpacity(0.8),
        textColor: Colors.white,
        webPosition: "center",
        fontSize: 16.0);
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        leading: BackButton(
            color: Colors.black,
            onPressed: () => NavigateToOrderPage(widget.bill)),
        actions: [
          GestureDetector(
              onTap: () => handleDeleteBill(),
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Icon(Icons.delete_outline,
                      color: Colors.black, size: 30))),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
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
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Slidable(
                                endActionPane: ActionPane(
                                    extentRatio: 0.25,
                                    motion: ScrollMotion(),
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                              left: 10,
                                              top: 10,
                                              bottom: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color:
                                                  Colors.red.withOpacity(0.3),
                                            ),
                                            child: Icon(Icons.delete_outline,
                                                color: Colors.red),
                                          ),
                                          onTap: () => handleDelete(
                                              widget.bill.dishes[index]),
                                        ),
                                      ),
                                      // SlidableAction(
                                      //   onPressed: (context) {},
                                      //   backgroundColor: Color(0xFF0392CF),
                                      //   foregroundColor: Colors.white,
                                      //   icon: Icons.save,
                                      //   label: 'Save',
                                      // ),
                                    ]),
                                child: ItemList(
                                    bill: widget.bill,
                                    dish: widget.bill.dishes[index],
                                    onChanged: (val) {
                                      setState(() {});
                                    }),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => Dash(
                                    length: size.width - 40,
                                    dashColor: kBackgroundColor),
                            itemCount: widget.bill.dishes.length)),
                    Dash(length: size.width - 40, dashColor: kBackgroundColor),
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
                          Text("${numFormat.format(widget.bill.totalPrice)}đ ",
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
        alignment: Alignment.center,
        height: 90,
        color: Colors.white,
        child: Column(children: [
          Container(
              height: 90,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // GestureDetector(
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     padding: EdgeInsets.all(12),
                  //     decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         // borderRadius: BorderRadius.circular(100),
                  //         border: Border.all(
                  //             color: Colors.black,
                  //             style: BorderStyle.solid,
                  //             width: 1.0)),
                  //     child: Icon(
                  //       Icons.save,
                  //       size: 32,
                  //     ),
                  //   ),
                  //   onTap: () => handleSave(),
                  // ),
                  Expanded(
                    flex: 2,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tổng tiền",
                              style: TextStyle(
                                  fontSize: 20, color: kBackgroundColor)),
                          Text("${numFormat.format(widget.bill.totalPrice)}đ",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold))
                        ]),
                  ),

                  Expanded(
                    flex: 2,
                    child: OrderListButton(
                      title: "THANH TOÁN",
                      color: kBlackColor,
                      icon: Icons.shopping_basket_outlined,
                      onPressed: () => {
                        handlePay(context),
                      },
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
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String? title;
  final Color? color;
  final IconData? icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color!),
            minimumSize: MaterialStateProperty.all(Size(50, 200)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text("${title}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
            ],
          ),
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
        int price = (widget.dish.totalPrice / widget.dish.quantity).toInt();
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
      int price = (widget.dish.totalPrice / widget.dish.quantity).toInt();
      print(price);
      widget.dish.quantity = ++widget.dish.quantity;
      print(widget.dish.quantity);
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
        padding: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        height: widget.dish.note!.isEmpty ? 126 : 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              height: 85,
              child: Row(
                children: [
                  Container(
                    height: 85,
                    width: 85,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: NetworkImage(widget.dish.dish.image[0]),
                        // image: AssetImage("assets/images/noimages.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.dish.dish.title}",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: buildList(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("${numFormat.format(widget.dish.totalPrice)}đ",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          )),
                      Container(
                        height: 60,
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
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                    kBlackColor,
                                  )),
                                  child: Text("-",
                                      style: TextStyle(color: Colors.white)),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              kBlackColor)),
                                  child: Text("+",
                                      style: TextStyle(color: Colors.white)),
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
                  )
                ],
              ),
            ),
            widget.dish.note!.isEmpty
                ? const SizedBox(height: 0)
                : Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    // margin: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Icon(Icons.note, color: kBackgroundColor),
                        const SizedBox(width: 10),
                        Text(
                          "${widget.dish.note}",
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
            // Divider(thickness: 1.0),
          ],
        ));
  }
}
