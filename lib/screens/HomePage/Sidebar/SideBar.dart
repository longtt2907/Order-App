// ignore_for_file: prefer_const_constructors

import 'package:demo_12_03/screens/AddFood/AddFood.dart';
import 'package:demo_12_03/screens/AddOption_tamthoi/AddOption_main.dart';
import 'package:demo_12_03/screens/Food_Screen/food_screen.dart';
import 'package:demo_12_03/screens/Login/login_screen.dart';
import 'package:demo_12_03/screens/Order/Order.dart';
import 'package:demo_12_03/screens/Receipt/reciept.dart';
import 'package:demo_12_03/constants.dart';
import "package:flutter/material.dart";
import 'dart:developer';

final padding = EdgeInsets.symmetric(horizontal: 20);

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool checkMatHang = false;
  bool checkDoanhThu = false;
  void clickMatHang() {
    setState(() {
      checkMatHang = !checkMatHang;
      if (checkDoanhThu = true) {
        checkDoanhThu = !checkDoanhThu;
      }
    });
    log('$checkMatHang');
  }

  void clickDoanhThu() {
    setState(() {
      checkDoanhThu = !checkDoanhThu;
      if (checkMatHang = true) {
        checkMatHang = !checkMatHang;
      }
    });
    log('$checkDoanhThu');
  }

  @override
  Widget build(BuildContext context) {
    // final padding = EdgeInsets.symmetric(horizontal: 20);
    Size size = MediaQuery.of(context).size;
    return Drawer(
        backgroundColor: kPrimaryColor,
        elevation: 4,
        child: Material(
            color: kPrimaryColor,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: [
                const SizedBox(height: 100),
                const SizedBox(height: 16),
                buildMenuItem(
                  text: "Quản lí doanh thu",
                  icon: Icons.manage_accounts,
                  onTap: () => clickDoanhThu(),
                ),
                checkDoanhThu != false
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                width: 0.8),
                          ),
                        ),
                        child: ListView(shrinkWrap: true, children: [
                          buildMenuChildItem(
                            text: "Ngày",
                            onTap: () => selectedItem(context, 0),
                          ),
                          const SizedBox(height: 10),
                          buildMenuChildItem(
                            text: "Tháng",
                            onTap: () => selectedItem(context, 1),
                          ),
                          const SizedBox(height: 10),
                          buildMenuChildItem(
                            text: "Năm",
                            onTap: () => selectedItem(context, 2),
                          ),
                        ]))
                    : const SizedBox(height: 0),
                const SizedBox(height: 16),
                buildMenuItem(
                  text: "Quản lí mặt hàng",
                  onTap: () => clickMatHang(),
                  icon: Icons.production_quantity_limits,
                ),
                checkMatHang != false
                    ? Container(
                        padding: padding,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                width: 0.8),
                          ),
                        ),
                        child: ListView(shrinkWrap: true, children: [
                          const SizedBox(height: 10),
                          buildMenuChildItem(
                            text: "Quản lí danh mục",
                            onTap: () => selectedItem(context, 3),
                          ),
                          const SizedBox(height: 10),
                          buildMenuChildItem(
                            text: "Quản lí thực đơn",
                            onTap: () => selectedItem(context, 4),
                          ),
                        ]))
                    : const SizedBox(height: 0),
                const SizedBox(height: 16),
                buildMenuItem(
                  text: "Quản lí đơn hàng",
                  onTap: () => selectedItem(context, 5),
                  icon: Icons.production_quantity_limits,
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  text: "Quản lí thiết bị",
                  icon: Icons.manage_accounts,
                  onTap: () => selectedItem(context, 6),
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.white70, thickness: 1.0),
                const SizedBox(height: 16),
                buildMenuItem(
                  text: "Đăng xuất",
                  icon: Icons.manage_accounts,
                  onTap: () => selectedItem(context, 7),
                ),
              ],
            )));
  }
}

void selectedItem(BuildContext context, int index) {
  Navigator.pop(context);
  switch (index) {
    case 0:
    case 1:
    case 2:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Order(),
      ));
      break;
    case 3:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddOptionMain(),
      ));

      break;
    case 4:
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodScreen(),
          ));
      break;
    case 5:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ReceiptManage(),
      ));
      break;
    case 7:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Login(),
      ));
      break;
  }
}

Widget buildMenuItem({
  required String text,
  required IconData icon,
  required VoidCallback onTap,
}) {
  final color = Colors.white;
  final hoverColor = Colors.white70;
  return ListTile(
    // contentPadding: padding,
    leading: Icon(icon, color: color),
    title: Text(text, style: TextStyle(color: color, fontSize: 20)),
    hoverColor: hoverColor,
    onTap: onTap,
  );
}

Widget buildMenuChildItem({
  required String text,
  required VoidCallback onTap,
}) {
  final color = Colors.white;
  final hoverColor = Colors.white70;
  return ListTile(
    title: Text(text, style: TextStyle(color: color, fontSize: 20)),
    hoverColor: hoverColor,
    onTap: onTap,
  );
}
