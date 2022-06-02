import 'dart:developer';

import 'package:demo_12_03/screens/HomePage/HomePage.dart';
import 'package:demo_12_03/screens/Order/Components/Body/ItemsOrder.dart';
import 'package:demo_12_03/screens/Order/Components/BottomBar/BottomBar.dart';
import 'package:demo_12_03/screens/Order/Components/Sidebar/SidebarOrder.dart';
import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/models/product_model.dart';
import 'package:demo_12_03/screens/Order/Components/Table.dart';
import 'package:demo_12_03/screens/Order/Components/tab_widget.dart';
import 'package:demo_12_03/screens/Order/ProductDetail.dart';
import 'package:flutter/material.dart';
import 'package:momo_vn/momo_vn.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scroll_to_id/scroll_to_id.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../controllers/category_controller.dart';
import '../../controllers/product_controller.dart';
import '../../models/bill_model.dart';
import '../../models/category_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class Order extends StatefulWidget {
  late Bill? bill;
  Order({Key? key, this.bill}) : super(key: key);
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  late ScrollToId scrollToId;
  final ScrollController scrollController = ScrollController();
  PageController pageController = PageController();
  List<Product> listProducts = [];
  List<Category> listCategory = [];
  // int _selectedIndex = 0;
  String selectedCategory = "";

  late MomoVn _momoPay;
  late PaymentResponse _momoPaymentResult;
  late String _paymentStatus;

  // void onTapp(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  //   pageController.animateToPage(index,
  //       duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
  // }

  @override
  void initState() {
    super.initState();
    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
    initPlatformState();

    /// Create ScrollToId instance
    scrollToId = ScrollToId(scrollController: scrollController);
  }

  handleSelectCategory(String cateId) {
    setState(() {
      selectedCategory = cateId;
    });
    scrollToId.animateTo(cateId,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _momoPay.clear();
  }

  void _setState() {
    _paymentStatus = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess == true) {
      _paymentStatus += "\nTình trạng: Thành công.";
      _paymentStatus +=
          "\nSố điện thoại: " + _momoPaymentResult.phoneNumber.toString();
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra!;
      _paymentStatus += "\nToken: " + _momoPaymentResult.token.toString();
    } else {
      _paymentStatus += "\nTình trạng: Thất bại.";
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra.toString();
      _paymentStatus += "\nMã lỗi: " + _momoPaymentResult.status.toString();
    }
  }

  void _handlePaymentSuccess(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(
        msg: "THÀNH CÔNG: " + response.phoneNumber.toString(),
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(
        msg: "THẤT BẠI: " + response.message.toString(),
        toastLength: Toast.LENGTH_SHORT);
  }

  _handlePayment() async {
    print("đã vô");
    MomoPaymentInfo options = MomoPaymentInfo(
        merchantName: "Photoos Social Media",
        appScheme: "MOMONITG20220505",
        merchantCode: 'MOMONITG20220505',
        partnerCode: 'MOMONITG20220505',
        amount: int.parse(20000.toString()),
        orderId: 'ORD' + DateTime.now().millisecondsSinceEpoch.toString(),
        orderLabel: 'MGD',
        merchantNameLabel: "ABGD",
        fee: 0,
        description: 'Thanh toán hóa đơn',
        username: 'vuongquocvinh.bh@gmail.com',
        partner: 'merchant',
        extra: "",
        isTestMode: true);
    try {
      _momoPay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: LabelText("Order", Colors.black54),
          centerTitle: false,
          leading: BackButton(
              color: Colors.black,
              onPressed: () => {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()))
                  }),
        ),
        // bottomNavigationBar: widget.bill == null
        //     ? BottomNavigationBar(
        //         items: const <BottomNavigationBarItem>[
        //           BottomNavigationBarItem(
        //               icon: Icon(Icons.home), label: "Table"),
        //           BottomNavigationBarItem(
        //               icon: Icon(Icons.food_bank), label: "Order")
        //         ],
        //         onTap: onTapp,
        //         selectedItemColor: kPrimaryColor,
        //         currentIndex: _selectedIndex,
        //       )
        //     : null,
        body: widget.bill != null
            ? SlidingUpPanel(
                minHeight: 86,
                panelBuilder: (scrollController) =>
                    buildSlidingPanel(scrollController: scrollController),
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: PageView(
                    controller: pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      buildBody(size.height),
                      TableOrder(),
                    ],
                  ),
                ))
            : Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: PageView(
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    buildBody(size.height),
                    TableOrder(),
                  ],
                ),
              ));
  }

  Widget buildSlidingPanel({required ScrollController scrollController}) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(16),
              child: AppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                bottomOpacity: 0.0,
                elevation: 0.0,
                title: buildDragIcon(),
                centerTitle: true,
              ),
            ),
            body: TabWidget(
              scrollController: scrollController,
              bill: widget.bill,
              // onPressed: () => handlePaymentMomo,
            )));
  }

  Widget buildDragIcon() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        width: 42,
        height: 6);
  }

  Widget buildBody(double height) {
    return Container(
      margin: widget.bill != null ? const EdgeInsets.only(bottom: 170) : null,
      width: double.infinity,
      height: double.infinity,
      child: FutureBuilder(
          future: CategoryService().getCategories(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
            if (snapshot.hasData) {
              listCategory =
                  listCategory.isNotEmpty ? listCategory : snapshot.data!;

              return Column(
                children: [
                  FutureBuilder(
                      future: ProductService().getProducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Product>> snapshot) {
                        if (snapshot.hasData) {
                          listProducts = listProducts.isNotEmpty
                              ? listProducts
                              : snapshot.data!;
                          selectedCategory = selectedCategory.isNotEmpty
                              ? selectedCategory
                              : listCategory[0].id;

                          return Expanded(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  _sidebarFood(),
                                  showListFood()
                                ]),
                          );
                          // Row(children: [
                          //   SideBarOrder(
                          //       scrollToId: scrollToId, categories: categories),
                          //   Expanded(
                          //     child: MainBody(
                          //       scrollToId: scrollToId,
                          //       products: products,
                          //       categories: categories,
                          //       bill: widget.bill,
                          //     ),
                          //   )
                          // ]);
                        }

                        return const Center(child: CircularProgressIndicator());
                      }),
                ],
              );
            }

            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _sidebarFood() {
    return Expanded(
      flex: 0,
      child: SingleChildScrollView(
          child: Column(
              children: listCategory.map((category) {
        return Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: RotatedBox(
            quarterTurns: 3,
            child: TextButton(
              style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all(kPrimaryColor.withOpacity(0.1)),
              ),
              onPressed: () => handleSelectCategory(category.id),
              child: Column(
                children: [
                  Text(category.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: selectedCategory == category.id
                              ? kPrimaryColor
                              : Color(0xFFD4D4D4))),
                  selectedCategory == category.id
                      ? Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.all(3),
                          decoration: new BoxDecoration(
                            color: Color(0xFF51CBA2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(left: 5),
                          padding: EdgeInsets.all(2),
                        )
                ],
              ),
            ),
          ),
        );
      }).toList())),
    );
  }

  Widget showListFood() {
    return Expanded(
        child: InteractiveScrollViewer(
            scrollToId: scrollToId,
            children: listCategory.map((category) {
              return ScrollContent(
                  id: category.id,
                  child: GridView.builder(
                      padding: listCategory.indexOf(category) > 0
                          ? const EdgeInsets.fromLTRB(10, 20, 2, 10)
                          : const EdgeInsets.fromLTRB(10, 10, 2, 10),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.78,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                      ),
                      itemCount: listProducts
                          .where((product) => product.category == category.id)
                          .toList()
                          .length,
                      itemBuilder: (BuildContext context, index) {
                        return foodItem(listProducts
                            .where((product) => product.category == category.id)
                            .toList()[index]);
                      }));
            }).toList()));
  }

  Widget foodItem(product) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(1, 2))
            ]),
        child: TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            overlayColor: MaterialStateProperty.all(
              kPrimaryColor.withOpacity(0.1),
            ),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
          ),
          onPressed: () {
            print("123124");
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ProductDetail(product: product, bill: widget.bill),
            ));
          },
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 4,
                    child: product.image.isEmpty
                        ? Ink(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/noimages.png"),
                                  fit: BoxFit.cover,
                                )))
                        : Ink(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                image: DecorationImage(
                                  image: NetworkImage(product.image[0]),
                                  fit: BoxFit.contain,
                                )))),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(product.title,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF7E7E7E))),
                    )),
              ]),
        ));
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
