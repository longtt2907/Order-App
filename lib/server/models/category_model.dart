import 'package:flutter/foundation.dart';

class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['_id'] as String , name: json['name'] as String);
  }
}
