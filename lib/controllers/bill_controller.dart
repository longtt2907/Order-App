import 'dart:convert';
import 'dart:developer';

import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/models/bill_model.dart';
import 'package:http/http.dart';

class BillService {
  final String billUrl = "$BASE_URL/api/bills";
  Future<List<Bill>> getBills() async {
    Response res = await get(
      Uri.parse(billUrl),
    );
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Bill> bills =
          body.map((dynamic item) => Bill.fromJson(item)).toList();
      return bills;
    } else {
      throw "Can't get bills";
    }
  }

  Future<Bill> createbill(Bill bill) async {
    List jsonList = bill.dishes.map((dish) {
      List subDishList = dish.subDish.map((item) => item.id).toList();
      return {
        "dish": dish.dish.id,
        "subDish": subDishList,
        "size": dish.size,
        'totalPrice': dish.totalPrice,
        "quantity": dish.quantity,
        "note": dish.note,
      };
    }).toList();

    Response res = await post(Uri.parse(billUrl),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: jsonEncode({
          "user": "627f25143ecf34dee89e1aee",
          "dishes": jsonList,
          "total": bill.totalPrice,
          "status": bill.status,
          // "totalPrice": bill.totalPrice,
          // "type":bill.type,
        }));

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      Bill newBill = Bill.fromJson(body);

      return newBill;
    } else {
      throw "Fail to create bill";
    }
  }

  Future<List<Bill>> getAllBills() async {
    Response res = await get(
      Uri.parse(billUrl),
    );
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Bill> bills =
          body.map((dynamic item) => Bill.fromJson(item)).toList();
      return bills;
    } else {
      throw "Can't get bills";
    }
  }

  Future<List<Bill>> getBillsByDate(String timestamp, String type) async {
    Response res = await get(
      Uri.parse(billUrl + "/date" + "?t=" + timestamp + "&type=" + type),
    );
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Bill> bills =
          body.map((dynamic item) => Bill.fromJson(item)).toList();
      return bills;
    } else {
      throw "Can't get bills";
    }
  }

  Future<List<int>> getBillsEveryMonth() async {
    List<int> data = [];
    for (int i = 1; i <= 12; i++) {
      DateTime dt = new DateTime.now();
      String timestamp =
          (new DateTime(dt.year, i, 1).millisecondsSinceEpoch ~/ 1000)
              .toString();
      int doanhthu = 0;
      List<Bill> bills = await BillService().getBillsByDate(timestamp, 'month');
      for (Bill bill in bills) {
        if (bill.status == true) {
          doanhthu = doanhthu + bill.total!;
        }
      }
      data.add(doanhthu);
    }
    return data;
  }
}
