import 'package:demo_12_03/models/product_model.dart';
import 'package:demo_12_03/models/user_model.dart';
import 'package:flutter/foundation.dart';

class Bill {
  final String? id;
  // final String? table;
  final User? user;
  late List<dynamic> dishes;
  late int? total = 0;
  late bool? status;
  late bool? type;
  late int? totalPrice = 0;
  late String? createdAt;
  Bill(
      {Key? key,
      required this.id,
      // this.table,
      this.user,
      required this.dishes,
      required this.total,
      this.totalPrice,
      this.status,
      this.type,
      this.createdAt});
  factory Bill.fromJson(Map<String, dynamic> json) {
    List<dynamic> bodyDish = json['dishes'];
    List<Dish> dishes =
        bodyDish.map((dynamic item) => Dish.fromJson(item)).toList();

    User user = User.fromJson(json['user']);
    return Bill(
        id: json['_id'] as String,
        // table: json['table'] as String,
        user: user,
        dishes: dishes,
        totalPrice: json['totalPrice'] as int,
        total: json['total'] as int,
        status: json['status'] as bool,
        type: json['type'] as bool,
        createdAt: json['createdAt'] as String);
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

    Product dish = Product.fromJson(json['dish']);
    // print(bodyDish);
    // print(json['dish']);
    // print(json['subDish']);
    // print(subDish);
    return Dish(
      id: json['_id'] as String,
      dish: dish,
      subDish: subDish,
      size: json['size'] as String,
      totalPrice: json['totalPrice'] as int,
      quantity: json['quantity'] as int,
      note: json['note'] as String,
    );
  }
}
