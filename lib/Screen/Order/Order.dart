import 'dart:developer';

import 'package:demo_12_03/Screen/Order/Components/Body/ItemsOrder.dart';
import 'package:demo_12_03/Screen/Order/Components/BottomBar/BottomBar.dart';
import 'package:demo_12_03/Screen/Order/Components/Sidebar/SidebarOrder.dart';
import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/server/models/product_model.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scroll_to_id/scroll_to_id.dart';

import '../../server/controllers/category_controller.dart';
import '../../server/controllers/product_controller.dart';
import '../../server/models/bill_model.dart';
import '../../server/models/category_model.dart';

class Order extends StatefulWidget {
  Order({Key? key, this.bill}) : super(key: key);
  late Bill? bill;
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  late ScrollToId scrollToId;
  final ScrollController scrollController = ScrollController();
  late List<Product> products = [];
  late List<Category> categories = [];

  // void _scrollListener() {
  //   print(scrollToId.idPosition());
  // }

  @override
  void initState() {
    super.initState();

    /// Create ScrollToId instance
    scrollToId = ScrollToId(scrollController: scrollController);

    // scrollController.addListener(_scrollListener);
  }

  /// Generate 10 Container
  /// Case [Axis.horizontal] set buildStackHorizontal() to body
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Order',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: LabelText("Order", Colors.black),
          centerTitle: false,
          leading: BackButton(
              color: Colors.black, onPressed: () => {Navigator.pop(context)}),
          backgroundColor: Colors.white,
          elevation: 4,
        ),
        body: buildBody(size.height),
        bottomSheet: widget.bill != null
            ? BottomContainer(size: size, bill: widget.bill!)
            : BottomContainer(
                size: size,
              ),
      ),
    );
  }

  Widget buildBody(double height) {
    return Container(
      margin: EdgeInsets.only(bottom: 110),
      child: Row(
        children: [
          FutureBuilder(
              future: categoryService().getCategories(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Category>> snapshot) {
                if (snapshot.hasData) {
                  categories = snapshot.data!;

                  return SideBarOrder(
                      scrollToId: scrollToId, categories: categories);
                }

                return const Center(child: CircularProgressIndicator());
              }),
          FutureBuilder(
              future: productService().getProducts(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Product>> snapshot) {
                if (snapshot.hasData) {
                  products = snapshot.data!;

                  return Expanded(
                    child: MainBody(
                      scrollToId: scrollToId,
                      products: products,
                      categories: categories,
                      bill: widget.bill,
                    ),
                  );
                }

                return const Center(child: CircularProgressIndicator());
              }),
        ],
      ),
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({
    Key? key,
    required this.scrollToId,
    required this.products,
    required this.categories,
    this.bill,
  }) : super(key: key);

  final ScrollToId scrollToId;
  final List<Product> products;
  final List<Category> categories;
  final Bill? bill;

  @override
  Widget build(BuildContext context) {
    return InteractiveScrollViewer(
      scrollToId: scrollToId,
      children: categories
          .map((category) => ScrollContent(
                id: category.id,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.grey[800]!,
                          style: BorderStyle.solid,
                          width: 0.8),
                    ),
                  ),
                  child: GridView(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                      childAspectRatio: 0.9,
                      // mainAxisExtent: 120,
                    ),
                    children: products
                        .where((product) => product.category == category.id)
                        .map((product) =>
                            ItemsOrder(product: product, bill: bill))
                        .toList(),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
