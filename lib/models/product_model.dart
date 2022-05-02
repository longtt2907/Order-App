import 'dart:convert';

import 'package:demo_12_03/models/category_model.dart';

class Product {
  final String? id;
  final String title;
  final String category;
  final String? description;
  final List<dynamic> image;
  final String unit;
  final List<dynamic> prices;
  final int quantity;
  final bool isLinked;
  final String? linkedCategory;
  final bool? isDeleted;

  Product(
      {required this.quantity,
      required this.isLinked,
      required this.linkedCategory,
      this.isDeleted,
      required this.prices,
      required this.category,
      this.description,
      required this.image,
      required this.unit,
      this.id,
      required this.title});

  factory Product.fromJson(Map<String, dynamic> json) {
    List<dynamic> bodyPrices = json['prices'];

    List<Price> prices =
        bodyPrices.map((dynamic item) => Price.fromJson(item)).toList();
    return Product(
        id: json['_id'] as String,
        title: json['title'] as String,
        category: json['category'] as String,
        description: json['description'] as String,
        image: json['image'] as List<dynamic>,
        unit: json['unit'] as String,
        prices: prices,
        quantity: json['quantity'] as int,
        isLinked: json['isLinked'] as bool,
        linkedCategory: json['linkedCategory'] as String,
        isDeleted: json['isDeleted'] as bool);
  }
}

class Price {
  final String id;
  final String title;
  final int price;

  Price({required this.id, required this.title, required this.price});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
        title: json['title'] as String,
        price: json['price'] as int,
        id: json['_id'] as String);
  }
}
