import 'dart:convert';

import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/models/category_model.dart';
import 'package:http/http.dart';

class CategoryService {
  final String categoryUrl = "$BASE_URL/api/categories";

  Future<List<Category>> getCategories() async {
    Response res = await get(Uri.parse(categoryUrl));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Category> categories =
          body.map((dynamic item) => Category.fromJson(item)).toList();

      return categories;
    } else {
      throw "Can't get categories";
    }
  }

  Future<Category> createCategory(String nameCate) async {
    Response res = await post(
      Uri.parse(categoryUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"name": nameCate}),
    );
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      Category category = Category.fromJson(body);
      return category;
    } else {
      throw "Fail to create category";
    }
  }

  Future<bool> deleteCategory(String categoryId) async {
    Response res = await delete(Uri.parse('$categoryUrl/$categoryId'));
    if (res.statusCode == 200) {
      return true;
    } else {
      throw "Fail to delete category";
    }
  }

  Future<Category> updateCategory(Category category) async {
    Response res = await put(Uri.parse('$categoryUrl/${category.id}'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: jsonEncode({"name": category.name}));

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      Category newCategory = Category.fromJson(body);

      return newCategory;
    } else {
      throw "Fail to update category";
    }
  }
}
