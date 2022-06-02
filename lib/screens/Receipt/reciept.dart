import 'dart:developer';

import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/controllers/bill_controller.dart';
import 'package:demo_12_03/models/bill_model.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class ReceiptManage extends StatefulWidget {
  const ReceiptManage({Key? key}) : super(key: key);

  @override
  State<ReceiptManage> createState() => _ReceiptManageState();
}

class _ReceiptManageState extends State<ReceiptManage> {
  final BillService billService = BillService();
  List<Bill> listBills = [];
  // int _revenueOfDay = 0;
  DateTime selectedDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 12, 0, 0);

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate =
            DateTime(picked.year, picked.month, picked.day, 12, 0, 0);
      });
    }
  }

  // Future<int> _handleRevenueOfDay(bills) async {
  //   int total = 0;
  //   for (Bill bill in listBills) {
  //     total += bill.total!;
  //   }

  //   setState(() {
  //     _revenueOfDay = total;
  //   });

  //   return total;
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hóa Đơn"),
          centerTitle: true,
          leading: BackButton(onPressed: () {
            Navigator.pop(context);
          }),
          backgroundColor: kPrimaryColor,
          elevation: 4,
        ),
        body: Container(
          padding: const EdgeInsets.all(6),
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DatePicker(
                      onPressed: _selectDate, selectedDate: selectedDate),
                  // FutureBuilder(
                  //     future: _handleRevenueOfDay(listBills),
                  //     builder:
                  //         (BuildContext context, AsyncSnapshot<int> snapshot) {
                  //       if (snapshot.hasData) {
                  //         _revenueOfDay = snapshot.data!;
                  //         print(snapshot.data!);
                  //         return Text(_revenueOfDay.toString());
                  //       }

                  //       return const Center(child: CircularProgressIndicator());
                  //     }),
                  // TextButton(
                  //     onPressed: () {
                  //       print(_revenueOfDay);
                  //     },
                  //     child: Text("Click"))
                ],
              ),
              FutureBuilder(
                  future: billService.getBillsByDate(
                      (selectedDate.millisecondsSinceEpoch ~/ 1000).toString(),
                      "date"),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Bill>> snapshot) {
                    if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Không có hóa đơn trong ngày",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      );
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      listBills = snapshot.data!;
                      return Expanded(child: showListBill());
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ],
          ),
        ));
  }

  Widget showListBill() {
    return ListView.builder(
        itemCount: listBills.length,
        itemBuilder: (BuildContext context, int index) {
          return rowItem(context, index);
        });
  }

  Widget rowItem(context, index) {
    return Card(
        child: InkWell(
      onTap: () {},
      child: ListTile(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            listBills[index].status!
                ? const StatusBill(color: kSuccessColor, title: "Đã hoàn tất")
                : const StatusBill(color: kDangerColor, title: "Đã hủy"),
            Text("${numFormat.format(listBills[index].total)}đ",
                style: const TextStyle(
                    color: kSuccessColor, fontWeight: FontWeight.w500))
          ]),
          subtitle: Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Ink(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                      // direction: Axis.vertical,
                      // spacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: listBills[index].dishes.map((item) {
                        return Text(
                            item.quantity.toString() +
                                " x " +
                                item.dish.title +
                                (() {
                                  if (item.subDish.length > 0) {
                                    return " - ";
                                  }
                                  return "";
                                }()) +
                                item.subDish.map((subItem) {
                                  return subItem.title;
                                }).join(", "),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700));
                      }).toList()),
                ),
                const SizedBox(height: 6),
                Row(children: [
                  const Text("Nhân viên:",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      )),
                  const SizedBox(width: 8),
                  Text(listBills[index].user!.fullName,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey[400])),
                ]),
                const SizedBox(height: 4),
                Row(children: [
                  const Text("Thanh toán lúc:",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      )),
                  const SizedBox(width: 8),
                  Text(
                      DateFormat("dd/MM/yyyy HH:mm").format(DateTime.parse(
                          listBills[index].createdAt.toString())),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey[400]))
                ]),
              ],
            ),
          )),
    ));
  }
}

class DatePicker extends StatelessWidget {
  final Function? onPressed;
  final DateTime selectedDate;

  const DatePicker({
    Key? key,
    this.onPressed,
    required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            // padding: MaterialStateProperty.all(EdgeInsets.zero),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            overlayColor:
                MaterialStateProperty.all(Colors.black.withOpacity(0.1))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_today, color: kPrimaryColor),
            const SizedBox(width: 10),
            Text(DateFormat("dd/MM/yyyy").format(selectedDate),
                style: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600))
          ],
        ),
        onPressed: () => onPressed!(context));
  }
}

class StatusBill extends StatelessWidget {
  final Color color;
  final String title;

  const StatusBill({
    Key? key,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 6,
          children: [
            Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                )),
            Text(title,
                style: TextStyle(
                    color: color, fontSize: 14, fontWeight: FontWeight.w600))
          ]),
    );
  }
}
