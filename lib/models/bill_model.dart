import 'package:demo_12_03/models/product_model.dart';
import 'package:flutter/foundation.dart';

class Bill {
  final String? id;
  final String? table;
  final String? user;
  late List<dynamic> dishes;
  late int? total = 0;
  late bool? status;
  late bool? type;
  late int? totalPrice = 0;
  Bill(
      {Key? Key,
      required this.id,
      this.table,
      this.user,
      required this.dishes,
      required this.total,
      this.totalPrice,
      this.status,
      this.type});
  factory Bill.fromJson(Map<String, dynamic> json) {
    List<dynamic> bodyDish = json['dish'];

    List<Dish> products =
        bodyDish.map((dynamic item) => Dish.fromJson(item)).toList();
    return Bill(
        id: json['_id'] as String,
        table: json['table'] as String,
        user: json['user'] as String,
        dishes: products,
        total: json['total'] as int,
        status: json['status'] as bool,
        type: json['type'] as bool);
  }
}

class Dish {
  final String? id;
  final Product dish;
  final List<Product>? subDish;
  final String size;
  final int price;
  late int totalPrice;
  late int quantity;
  final String? note;
  Dish({
    Key? key,
    this.id,
    required this.dish,
    this.subDish,
    required this.price,
    required this.size,
    required this.totalPrice,
    required this.quantity,
    this.note,
  });
  factory Dish.fromJson(Map<String, dynamic> json) {
    List<dynamic> bodyProducts = json['subDish'];

    List<Product> subDish =
        bodyProducts.map((dynamic item) => Product.fromJson(item)).toList();
    return Dish(
      id: json['_id'] as String,
      dish: json['dish'] as Product,
      price: json['price'] as int,
      subDish: subDish,
      size: json['size'] as String,
      totalPrice: json['totalPrice'] as int,
      quantity: json['quantity'] as int,
      note: json['note'] as String,
    );
  }
}
