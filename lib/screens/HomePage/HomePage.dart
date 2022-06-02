import 'dart:developer';

import 'package:demo_12_03/controllers/bill_controller.dart';
import 'package:demo_12_03/controllers/category_controller.dart';
import 'package:demo_12_03/controllers/product_controller.dart';
import 'package:demo_12_03/models/bill_model.dart';
import 'package:demo_12_03/models/category_model.dart';
import 'package:demo_12_03/models/product_model.dart';
import 'package:demo_12_03/screens/HomePage/Body/chart.dart';
import 'package:demo_12_03/screens/HomePage/Body/dropDownList.dart';
import 'package:demo_12_03/screens/HomePage/Sidebar/SideBar.dart';
import 'package:demo_12_03/constants.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

const Color textColor = Colors.white;
const Color labelColor = Colors.black;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dateChoosed =
      (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
  List<Bill> bills = [];
  int doanhthu = 0;
  String _item = 'Ngày';
  String typeChoosed = 'day';
  String datetime =
      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';

  void handleDate(DateTime date) {
    doanhthu = 0;
    dateChoosed = (date.millisecondsSinceEpoch ~/ 1000).toString();
    log('${dateChoosed}');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        title: Text("Thêm món ăn"),
        centerTitle: true,
        // leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
        shadowColor: kPrimaryColor,
        backgroundColor: kPrimaryColor,
        // elevation: 4,
        elevation: 0,
      ),
      drawer: Sidebar(),
      body: Container(
        width: double.infinity,
        height: size.height,
        // padding: padding,
        color: Colors.white,
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            _buildHeader(size.height),
            SliverToBoxAdapter(
              child: const SizedBox(height: 20),
            ),
            _buildBodyChart(size.height),
            SliverToBoxAdapter(
              child: const SizedBox(height: 20),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildHeader(double height) {
    return SliverToBoxAdapter(
      child: Container(
          alignment: Alignment.center,
          height: height * 0.3,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(45.0),
              bottomRight: Radius.circular(45.0),
              // topLeft: Radius.circular(45.0),
              // topRight: Radius.circular(45.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // const SizedBox(height: 10),
              const Text(
                "DOANH THU",
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FutureBuilder(
                  future:
                      BillService().getBillsByDate(dateChoosed, typeChoosed),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Bill>> snapshot) {
                    if (snapshot.hasData) {
                      bills = snapshot.data!;
                      doanhthu = 0;
                      for (Bill bill in bills) {
                        doanhthu = doanhthu + bill.total!;
                      }
                      return Center(
                        child: Text(
                          "${numFormat.format(doanhthu)}đ",
                          style: const TextStyle(
                            color: textColor,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropDownList(
                    itemChoosed: _item,
                    items: const ['Ngày', 'Tháng', 'Năm'],
                    onChanged: (val) => setState(
                      () {
                        DateTime result = DateTime.now();
                        _item = val!;
                        switch (_item) {
                          case 'Ngày':
                            datetime =
                                "${result.day}/${result.month}/${result.year}";
                            typeChoosed = 'day';
                            break;
                          case 'Tháng':
                            datetime = "Tháng ${result.month}";
                            typeChoosed = 'month';
                            break;
                          case 'Năm':
                            datetime = "Năm ${result.year}";
                            typeChoosed = 'year';
                            break;
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    height: 50,
                    // decoration: BoxDecoration(
                    //   border: Border.all(
                    //       color: kPrimaryColor,
                    //       width: 0.7,
                    //       style: BorderStyle.solid),
                    // ),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              kPrimaryTextColor),
                        ),
                        child:
                            Text('${datetime}', style: TextStyle(fontSize: 16)),
                        onPressed: () async {
                          final result = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2015),
                            lastDate: DateTime(2030),
                          );
                          if (result != null) {
                            handleDate(result);
                            log('${result}');
                            setState(() {
                              switch (_item) {
                                case 'Ngày':
                                  datetime =
                                      "${result.day}/${result.month}/${result.year}";
                                  break;
                                case 'Tháng':
                                  datetime = "Tháng ${result.month}";
                                  break;
                                case 'Năm':
                                  datetime = "Năm ${result.year}";
                                  break;
                              }
                            });
                          }
                        }),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

SliverToBoxAdapter _buildBodyChart(double height) {
  List<Product> products = [];
  List<Category> categories = [];
  List<Bill> bills = [];
  return SliverToBoxAdapter(
    child: Container(
        height: height * 0.7,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          // boxShadow:,
          // border: Border.all(
          //     color: labelColor,
          //     width: 0.5,
          //     style: BorderStyle.solid),
          // borderRadius: BorderRadius.circular(5),
        ),
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

                        return FutureBuilder(
                            future: ProductService().getProducts(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Product>> snapshot) {
                              if (snapshot.hasData) {
                                products = snapshot.data!;

                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconContainer(
                                          icon: Icons.category,
                                          text: "${categories.length}",
                                          color: Color(0xFF809A6F),
                                        ),
                                        IconContainer(
                                          icon: Icons.food_bank,
                                          text: "${products.length}",
                                          color: Color(0xFFA25B5B),
                                        ),
                                        IconContainer(
                                          icon: Icons.receipt,
                                          text: "15",
                                          color: Color(0xFFCC9C75),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Divider(
                                        height: 1.0,
                                        thickness: 1.0,
                                        color: textColor),
                                    const SizedBox(height: 20),
                                    Expanded(
                                      child: SizedBox(
                                        height: height * 0.4,
                                        child: TimeSeriesBar.withSampleData(),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFFA2D2FF),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Doanh thu",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "1.000.000",
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Text("213125%",
                                              style: TextStyle(fontSize: 20))
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            });
                      }
                      return const Center(child: CircularProgressIndicator());
                    });
              }
              return const Center(child: CircularProgressIndicator());
            })),
  );
}

class IconContainer extends StatelessWidget {
  const IconContainer({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon, color: color, size: 35),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: labelColor,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
