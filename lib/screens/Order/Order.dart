import 'dart:developer';

import 'package:demo_12_03/screens/HomePage/HomePage.dart';
import 'package:demo_12_03/screens/Order/Components/Body/ItemsOrder.dart';
import 'package:demo_12_03/screens/Order/Components/BottomBar/BottomBar.dart';
import 'package:demo_12_03/screens/Order/Components/Sidebar/SidebarOrder.dart';
import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/models/product_model.dart';
import 'package:demo_12_03/screens/Order/Components/Table.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scroll_to_id/scroll_to_id.dart';

import '../../controllers/category_controller.dart';
import '../../controllers/product_controller.dart';
import '../../models/bill_model.dart';
import '../../models/category_model.dart';

class Order extends StatefulWidget {
  late Bill? bill;
  Order({Key? key, this.bill}) : super(key: key);
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  late ScrollToId scrollToId;
  final ScrollController scrollController = ScrollController();
  late List<Product> products = [];
  late List<Category> categories = [];
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void onTapp(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
  }
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
                color: Colors.black,
                onPressed: () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()))
                    }),
            backgroundColor: Colors.white,
            elevation: 4,
          ),
          bottomNavigationBar: widget.bill == null
              ? BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: "Table"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.food_bank), label: "Order")
                  ],
                  onTap: onTapp,
                  selectedItemColor: kPrimaryColor,
                  currentIndex: _selectedIndex,
                )
              : null,
          body: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              buildBody(size.height),
              TableOrder(),
            ],
          ),
          bottomSheet: widget.bill != null
              ? BottomContainer(size: size, bill: widget.bill!)
              : null),
    );
  }

  Widget buildBody(double height) {
    return Container(
      margin: widget.bill != null ? EdgeInsets.only(bottom: 140) : null,
      child: FutureBuilder(
          future: CategoryService().getCategories(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
            if (snapshot.hasData) {
              categories = snapshot.data!;

              return FutureBuilder(
                  future: ProductService().getProducts(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Product>> snapshot) {
                    if (snapshot.hasData) {
                      products = snapshot.data!;

                      return Row(children: [
                        SideBarOrder(
                            scrollToId: scrollToId, categories: categories),
                        Expanded(
                          child: MainBody(
                            scrollToId: scrollToId,
                            products: products,
                            categories: categories,
                            bill: widget.bill,
                          ),
                        )
                      ]);
                    }

                    return const Center(child: CircularProgressIndicator());
                  });
            }

            return const Center(child: CircularProgressIndicator());
          }),
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
