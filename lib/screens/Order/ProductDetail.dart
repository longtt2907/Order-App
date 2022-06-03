import 'dart:developer';

import 'package:demo_12_03/components/multi_select.dart';
import 'package:demo_12_03/components/round_prefix_icon_button.dart';
import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/controllers/product_controller.dart';
import 'package:demo_12_03/models/bill_model.dart';
import 'package:demo_12_03/models/product_model.dart';
import 'package:demo_12_03/screens/AddOption_tamthoi/ChooseList.dart';
import 'package:demo_12_03/screens/Order/Order.dart';
import 'package:demo_12_03/screens/Order/OrderList.dart';
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
  late int priceInfo = widget.product.prices[0].price;
  late String dishSize = widget.product.prices[0].title;
  late int quantity = 1;
  late List<Product> subDish = [];
  late String userId;
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
        // user:userId,
        dishes: [newDish],
        total: newDish.quantity,
        totalPrice: newDish.totalPrice,
        status: true,
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
    return MaterialApp(
      title: 'App Order',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Roboto",
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          backgroundColor: Colors.white),
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kBlackColor,
              fontSize: 22,
            ),
          ),
          elevation: 0,
          centerTitle: false,
          leading: BackButton(
              color: kBlackColor, onPressed: () => {Navigator.pop(context)}),
          backgroundColor: Colors.transparent,
          // elevation: 4,
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
                        height: 350,
                        width: double.infinity,
                        padding: padding,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: NetworkImage(widget.product.image[0]),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      //title food
                      Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${widget.product.title}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28,
                                    color: kBlackColor)),
                            Text(
                              priceInfo == 0
                                  ? "${numFormat.format(widget.product.prices[0].price)}đ"
                                  : "${numFormat.format(priceInfo)}đ",
                              style: TextStyle(
                                  fontFamily: "Lato",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                      // price & quantity
                      // Container(
                      //   alignment: Alignment.centerLeft,
                      //   padding: padding,
                      //   child: Text(
                      //     priceInfo == 0
                      //         ? "${numFormat.format(widget.product.prices[0].price)}đ"
                      //         : "${numFormat.format(priceInfo)}đ",
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 20,
                      //         color: Colors.black45),
                      //   ),
                      // ),
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
                              subDish: subDish,
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
                              fillColor: Color(0xFF0F4C75),
                              focusColor: Color(0xFF0F4C75),
                              hoverColor: Color(0xFF0F4C75),
                              hintText: "Ghi chú",
                            ),
                            onChanged: (val) {
                              description = val;
                            },
                            maxLines: 1,
                          )),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100),
              // RoundPrefixIconButton(
              //     text: 'Xác nhận',
              //     icon: Icon(Icons.check, color: kPrimaryColor),
              //     color: kPrimaryColor,
              //     textColor: Colors.white,
              //     press: () {
              //       handleSubmit();
              //     }),
              // const SizedBox(height: 15),
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
                    // Expanded(
                    //   flex: 2,
                    //   child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text("Tổng tiền",
                    //             style: TextStyle(
                    //                 fontSize: 20, color: kBackgroundColor)),
                    //         Text(
                    //             "${numFormat.format((priceInfo + priceDetail) * quantity)}đ",
                    //             style: TextStyle(
                    //                 fontSize: 30, fontWeight: FontWeight.bold))
                    //       ]),
                    // ),
                    Expanded(
                      flex: 2,
                      child: Quantity(onChanged: (index) {
                        // setState(() {
                        //   quantity = index;
                        // });
                        quantity = index;
                      }),
                    ),
                    Expanded(
                      flex: 2,
                      child: OrderListButton(
                        title: "THANH TOÁN",
                        // color: Color(0xFF343A40),
                        color: kBlackColor,
                        icon: Icons.shopping_basket_outlined,
                        onPressed: () => {
                          handleSubmit(),
                        },
                      ),
                    ),
                  ],
                ))
          ]),
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
  String priceChoosed = '';

  @override
  void initState() {
    priceChoosed = widget.widget.product.prices[0].title;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          // color: Colors.black.withOpacity(0.8),
          color: Color(0xFF0F4C75)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.widget.product.prices
            .map((price) => SizeItem(
                size: price.title,
                choosen: priceChoosed == price.title ? true : false,
                onChanged: () {
                  // setState(() {
                  priceChoosed = price.title;
                  // });
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
    required this.subDish,
  }) : super(key: key);

  final Product product;
  final Function(List<Product>) onChanged;
  final List<Product> subDish;

  @override
  State<Submenu> createState() => _SubmenuState();
}

class _SubmenuState extends State<Submenu> {
  List<Product> items = [];
  List<Product> itemsSelected = [];
  @override
  Widget build(BuildContext context) {
    widget.subDish.isEmpty
        ? itemsSelected = []
        : itemsSelected = widget.subDish;
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
                  color: kBlackColor),
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
                  child: MultiSelected(
                    items: items,
                    selectedItems: itemsSelected,
                    onChanged: (val) {
                      itemsSelected = val;
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
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 10, left: 10),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: choosen != false ? Colors.white : Colors.white54,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10),
          color: choosen != false
              ? Color.fromARGB(255, 75, 112, 137)
              : Color(0xFF0F4C75),
        ),
        // /Color(0xFF064663)
        child: Text("${size}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(
                  width: 1.5,
                  color: kBlackColor,
                ),
              ),
              backgroundColor: Colors.transparent,
              alignment: Alignment.center,
              fixedSize: const Size(35, 35)),
          child: Icon(Icons.remove_outlined, color: Colors.black),
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
              backgroundColor: kBlackColor,
              alignment: Alignment.center,
              fixedSize: const Size(35, 35)),
          child: Center(child: Icon(Icons.add_outlined, color: Colors.white)),
          onPressed: () => add(),
        ),
      ],
    );
  }
}
