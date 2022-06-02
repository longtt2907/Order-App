import 'package:demo_12_03/controllers/product_controller.dart';
import 'package:demo_12_03/models/product_model.dart';
import 'package:flutter/foundation.dart';

class Bill {
  final String? id;
  // final String? table;
  final String? user;
  late List<dynamic> dishes;
  late int? total = 0;
  late bool? status;
  late bool? type;
  late int? totalPrice = 0;
  Bill(
      {Key? Key,
      required this.id,
      // this.table,
      this.user = "627f25143ecf34dee89e1aee",
      required this.dishes,
      required this.total,
      this.totalPrice,
      this.status,
      this.type});
  factory Bill.fromJson(Map<String, dynamic> json) {
    List<dynamic> bodyDish = json['dishes'];
    // print(json['user']);
    List<Dish> dishes =
        bodyDish.map((dynamic item) => Dish.fromJson(item)).toList();
    return Bill(
        id: json['_id'] as String,
        // table: json['table'] as String,
        // user: json['user'] as String,
        dishes: dishes,
        totalPrice: json['totalPrice'] as int,
        total: json['total'] as int,
        status: json['status'] as bool,
        type: json['type'] as bool);
  }
}

class Dish {
  final String? id;
  final dynamic dish;
  final List<dynamic>? subDish;
  final String size;
  late int totalPrice;
  late int quantity;
  final String? note;
  Dish({
    Key? key,
    this.id,
    required this.dish,
    this.subDish,
    required this.size,
    required this.totalPrice,
    required this.quantity,
    this.note,
  });
  factory Dish.fromJson(Map<String, dynamic> json) {
    // List<dynamic> bodyProducts = json['subDish'] as List<dynamic>;
    // String dishId = json['dish'] as String;
    // Future<Product> dish = ProductService().getProductById(dishId);
    // List<Future<Product>> subDish = bodyProducts
    //     .map((dynamic item) => ProductService().getProductById(item as String))
    //     .toList();
    List<dynamic> bodyDish = json['subDish'];
    List<Product> subDish =
        bodyDish.map((dynamic item) => Product.fromJson(item)).toList();
    // print(bodyDish);
    // print(json['dish']);
    // print(json['subDish']);
    // print(subDish);
    return Dish(
      id: json['_id'] as String,
      dish: json['dish'],
      subDish: subDish,
      size: json['size'] as String,
      totalPrice: json['totalPrice'] as int,
      quantity: json['quantity'] as int,
      note: json['note'] as String,
    );
  }
}
