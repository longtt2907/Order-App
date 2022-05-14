import 'dart:developer';

import 'package:demo_12_03/screens/Order/Order.dart';
import 'package:demo_12_03/components/round_button.dart';
import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/controllers/product_controller.dart';
import "package:flutter/material.dart";

import '../../components/radio_button.dart';
import '../../models/bill_model.dart';
import '../../models/product_model.dart';
import '../AddOption_tamthoi/ChooseList.dart';

const backgroundColor = Colors.white;

class Pay extends StatefulWidget {
  Pay({Key? key, required this.product, this.bill}) : super(key: key);

  final Product product;
  late Bill? bill;

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  late String title;
  late int price = 0;
  late String description = "";
  late int priceDetail = 0;
  late int priceInfo = 0;
  late String dishSize;
  late int quantity = 1;
  late List<Product> subDish = [];

  void handleSubmit() {
    Dish newDish = Dish(
      dish: widget.product,
      subDish: subDish,
      size: dishSize,
      price: priceInfo,
      totalPrice: (priceDetail + priceInfo) * quantity,
      quantity: quantity,
      note: description,
    );
    if (widget.bill != null) {
      widget.bill!.dishes.add(newDish);
      widget.bill!.total = widget.bill!.total! + newDish.quantity;
      widget.bill!.totalPrice = widget.bill!.totalPrice! + newDish.totalPrice;
    } else {
      Bill newBill = Bill(
        id: '1',
        dishes: [newDish],
        total: newDish.quantity,
        totalPrice: newDish.totalPrice,
      );
      widget.bill = newBill;
    }
    NavigateToOrderPage(widget.bill!);
  }

  void NavigateToOrderPage(Bill bill) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Order(bill: bill),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pay",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        leading: BackButton(
            color: Colors.black, onPressed: () => {Navigator.pop(context)}),
        backgroundColor: Colors.white,
        elevation: 4,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 202, 201, 201),
        // padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(bottom: size.height < 600 ? 140 : 170),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 5),
              InfoPay(
                  size: size,
                  product: widget.product,
                  onChanged: (item) {
                    priceInfo = item.price;
                    dishSize = item.title;
                  }),
              widget.product.isLinked
                  ? DetailPay(
                      size: size,
                      product: widget.product,
                      onChanged: (items) {
                        priceDetail = 0;
                        subDish = items;
                        log('${subDish}');
                        for (var item in items)
                          priceDetail =
                              priceDetail + item.prices[0].price as int;
                      })
                  : const SizedBox(height: 0),
              NotePay(onChanged: (val) => {description = val}),
              const SizedBox(height: 5)
            ],
          ),
        ),
      ),
      bottomSheet: ConfirmPay(
        size: size,
        onChanged: (val) => {quantity = val},
        onSubmit: () => handleSubmit(),
      ),
    );
  }
}

class ConfirmPay extends StatefulWidget {
  const ConfirmPay({
    Key? key,
    required this.size,
    required this.onChanged,
    required this.onSubmit,
  }) : super(key: key);

  final Size size;
  final Function(int) onChanged;
  final Function() onSubmit;

  @override
  State<ConfirmPay> createState() => _ConfirmPayState();
}

class _ConfirmPayState extends State<ConfirmPay> {
  int i = 1; // đếm số lượng
  void subtract() {
    if (i > 1) {
      setState(() {
        i = --i;
      });
      widget.onChanged(i);
    }
  }

  void add() {
    setState(() {
      i = ++i;
    });
    widget.onChanged(i);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: widget.size.height < 600 ? 140 : 170,
      // margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        // color: Colors.white70,
        color: backgroundColor,
        border: Border.all(
          color: kBackgroundColor,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      // borderRadius: BorderRadius.circular(15),

      child: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
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
                      child: Text("-", style: TextStyle(color: Colors.white)),
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
                      child: Text("${i}",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black)),
                      child: Text("+", style: TextStyle(color: Colors.white)),
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
          SizedBox(
            height: widget.size.width * 0.2,
            child: RoundButton(
                text: 'Hoàn tất',
                color: kPrimaryColor,
                textColor: Colors.white,
                press: () => widget.onSubmit),
          ),
        ],
      ),
    );
  }
}

class NotePay extends StatelessWidget {
  const NotePay({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Ghi chú",
          ),
          onChanged: (val) => onChanged(val),
          maxLines: 4,
        ));
  }
}

class DetailPay extends StatelessWidget {
  const DetailPay({
    Key? key,
    required this.size,
    required this.product,
    required this.onChanged,
  }) : super(key: key);

  final Size size;
  final Product product;
  final Function(List<Product>) onChanged;

  @override
  Widget build(BuildContext context) {
    List<Product> items;
    List<Product> itemsSelected;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      // height: size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          product.isLinked
              ? Text("Submenu",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
              : const SizedBox(height: 0),
          const SizedBox(height: 10),
          // ignore: prefer_const_literals_to_create_immutables, prefer_const_constructors
          // ChooseOption(danhmuc: [
          //   "tran chau den",
          //   "tran chau trang",
          //   "banh plan",
          //   "kem cheese"
          // ]),
          FutureBuilder(
            future: ProductService()
                .getProductsByCategoryId(product.linkedCategory!),
            builder:
                (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
              if (snapshot.hasData) {
                items = snapshot.data!;
                return Center(
                  child: MultiSelect(
                    items: items,
                    selectedItems: [],
                    onChanged: (val) {
                      itemsSelected = val as List<Product>;
                      onChanged(itemsSelected);
                    },
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          )
        ],
      ),
    );
  }
}

class InfoPay extends StatelessWidget {
  const InfoPay({
    Key? key,
    required this.size,
    required this.product,
    required this.onChanged,
  }) : super(key: key);

  final Size size;
  final Product product;
  final Function(dynamic) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      // height: size.height * 0.3,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              product.image.isEmpty
                  ? Image.asset(
                      "assets/images/noimages.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.fitWidth,
                    )
                  : Image.network(
                      product.image[0],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
              Text(
                "${product.title}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(
            thickness: 1.0,
          ),
          Center(
            child: ChooseOption(
              items: product.prices,
              onChanged: (item) {
                onChanged(item);
              },
            ),
          ),
        ],
      ),
    );
  }
}
