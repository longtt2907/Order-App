import 'dart:convert';

import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/models/product_model.dart';
import 'package:http/http.dart';

class ProductService {
  final String productUrl = "$BASE_URL/api/products";

  Future<List<Product>> getProducts() async {
    Response res = await get(Uri.parse(productUrl));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Product> products =
          body.map((dynamic item) => Product.fromJson(item)).toList();
      return products;
    } else {
      throw "Can't get products";
    }
  }

  Future<Product> createProduct(Product product) async {
    List jsonList = product.prices
        .map((price) => {"title": price.title, "price": price.price})
        .toList();

    Response res = await post(Uri.parse(productUrl),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: jsonEncode({
          "title": product.title,
          "categoryId": product.category,
          "image": product.image,
          "prices": jsonList,
          "quantity": product.quantity.toString(),
          "unit": product.unit,
          "isLinked": product.isLinked,
          "linkedCategory": product.linkedCategory,
        }));

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      Product newProduct = Product.fromJson(body);

      return newProduct;
    } else {
      throw "Fail to create product";
    }
  }
}
