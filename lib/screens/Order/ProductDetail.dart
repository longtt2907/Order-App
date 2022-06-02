import 'dart:developer';

import 'package:demo_12_03/components/round_prefix_icon_button.dart';
import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/controllers/product_controller.dart';
import 'package:demo_12_03/models/bill_model.dart';
import 'package:demo_12_03/models/product_model.dart';
import 'package:demo_12_03/screens/AddOption_tamthoi/ChooseList.dart';
import 'package:demo_12_03/screens/Order/Order.dart';
import "package:flutter/material.dart";

class ProductDetail extends StatefulWidget {
  ProductDetail({Key? key, required this.product, this.bill}) : super(key: key);

  final Product product;
  late Bill? bill;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late String title;
  late int price = 0;
  late String description = "";
  late int priceDetail = 0;
  late int priceInfo = 0;
  late String dishSize;
  late int quantity = 1;
  late List<Product> subDish = [];
  // late String priceChoosed = '';

  void handleSubmit() {
    Dish newDish = Dish(
      dish: widget.product,
      subDish: subDish,
      size: dishSize,
      // price: priceInfo,
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
    const padding = EdgeInsets.symmetric(horizontal: 15);
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
        // padding: EdgeInsets.all(15),
        color: Colors.transparent,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // picture
                    Ink(
                      height: 400,
                      width: double.infinity,
                      padding: padding,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: NetworkImage(widget.product.image[0]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    //title food
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      padding: padding,
                      child: Text(
                        "${widget.product.title}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.black54),
                      ),
                    ),
                    // price & quantity
                    const SizedBox(height: 5),
                    Padding(
                      padding: padding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            priceInfo == 0
                                ? "${widget.product.prices[0].price}đ"
                                : "${priceInfo}đ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: kPrimaryColor.withOpacity(0.8)),
                          ),
                          Quantity(onChanged: (index) {
                            // setState(() {
                            //   quantity = index;
                            // });
                            quantity = index;
                          }),
                          //size
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    //choose size
                    SizeContainer(
                        widget: widget,
                        onChanged: (item) {
                          priceInfo = item.price;
                          dishSize = item.title;
                          setState(() {});
                        }),
                    const SizedBox(height: 15),
                    //liên kết kho
                    widget.product.isLinked
                        ? Submenu(
                            product: widget.product,
                            onChanged: (items) {
                              priceDetail = 0;
                              subDish = items;
                              for (var item in items)
                                priceDetail =
                                    priceDetail + item.prices[0].price as int;
                            })
                        : const SizedBox(height: 0),
                    //ghi chú
                    Container(
                        alignment: Alignment.center,
                        padding: padding,
                        // margin:
                        //     EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.red)),
                            fillColor: kPrimaryColor,
                            focusColor: kPrimaryColor,
                            hintText: "Ghi chú",
                          ),
                          onChanged: (val) {
                            description = val;
                          },
                          maxLines: 1,
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              margin: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 20),
                      width: size.width * 0.6,
                      height: 50,
              child: RoundPrefixIconButton(
                  text: 'Xác nhận',
                  icon: Icon(Icons.check, color: kPrimaryColor),
                  color: kPrimaryColor,
                  textColor: Colors.white,
                  press: () {
                    handleSubmit();
                  }),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class SizeContainer extends StatefulWidget {
  const SizeContainer({
    Key? key,
    required this.widget,
    required this.onChanged,
  }) : super(key: key);

  final ProductDetail widget;
  final Function(dynamic) onChanged;

  @override
  State<SizeContainer> createState() => _SizeContainerState();
}

class _SizeContainerState extends State<SizeContainer> {
  String priceChoosed = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.8),
      ),
      child: Row(
        children: widget.widget.product.prices
            .map((price) => SizeItem(
                size: price.title,
                choosen: priceChoosed == price.title ? true : false,
                onChanged: () {
                  setState(() {
                    priceChoosed = price.title;
                  });
                  widget.onChanged(price);
                }))
            .toList(),
      ),
    );
  }
}

class Submenu extends StatefulWidget {
  const Submenu({
    Key? key,
    required this.product,
    required this.onChanged,
  }) : super(key: key);

  final Product product;
  final Function(List<Product>) onChanged;

  @override
  State<Submenu> createState() => _SubmenuState();
}

class _SubmenuState extends State<Submenu> {
  List<Product> items = [];
  List<Product> itemsSelected = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            child: Text(
              "Menu thêm",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black54),
            ),
          ),
          FutureBuilder(
            future: ProductService()
                .getProductsByCategoryId(widget.product.linkedCategory!),
            builder:
                (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
              if (snapshot.hasData) {
                items = snapshot.data!;
                return Center(
                  child: MultiSelect(
                    items: items,
                    selectedItems: itemsSelected,
                    onChanged: (val) {
                      itemsSelected = val as List<Product>;
                      widget.onChanged(itemsSelected);
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

class SizeItem extends StatelessWidget {
  const SizeItem({
    Key? key,
    required this.size,
    this.choosen,
    required this.onChanged,
  }) : super(key: key);

  final String size;
  final bool? choosen;
  final Function() onChanged;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 10),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10),
          color:
              choosen != false ? Colors.white : kPrimaryColor.withOpacity(0.7),
        ),
        child: Text("${size}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: choosen != false
                  ? kPrimaryColor.withOpacity(0.7)
                  : Colors.white,
            )),
      ),
      onTap: () => onChanged(),
    );
  }
}

class Quantity extends StatefulWidget {
  const Quantity({Key? key, required this.onChanged}) : super(key: key);

  final Function(int) onChanged;

  @override
  State<Quantity> createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {
  int i = 1;
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(
                  width: 1.5,
                  color: kPrimaryColor.withOpacity(0.8),
                ),
              ),
              backgroundColor: Colors.transparent,
              alignment: Alignment.center,
              fixedSize: const Size(35, 35)),
          child: Text("-",
              style: TextStyle(
                  color: kPrimaryColor.withOpacity(0.8), fontSize: 20)),
          onPressed: () => subtract(),
        ),
        Container(
            alignment: Alignment.center,
            width: 35,
            height: 35,
            // margin: EdgeInsets.symmetric(horizontal: 5),
            // decoration: BoxDecoration(
            //     border: Border.all(
            //         color: Colors.black, width: 1.0, style: BorderStyle.solid)),
            child: Text("${i}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black54))),
        TextButton(
          style: TextButton.styleFrom(
              padding: EdgeInsets.all(0),
              shape: const CircleBorder(),
              backgroundColor: kPrimaryColor.withOpacity(0.8),
              alignment: Alignment.center,
              fixedSize: const Size(35, 35)),
          child: Center(
              child: Text("+",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ))),
          onPressed: () => add(),
        ),
      ],
    );
  }
}
