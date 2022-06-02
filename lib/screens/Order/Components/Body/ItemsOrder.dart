import 'dart:developer';

import 'package:demo_12_03/screens/Order/Pay.dart';
import 'package:demo_12_03/screens/Order/ProductDetail.dart';
import "package:flutter/material.dart";
import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/models/bill_model.dart';
import 'package:demo_12_03/models/product_model.dart';

class ItemsOrder extends StatelessWidget {
  const ItemsOrder({
    required this.product,
    this.bill,
    Key? key,
  }) : super(key: key);

  final Product product;
  final Bill? bill;
  void buildPayPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductDetail(product: product, bill: bill),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => buildPayPage(context),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: kBackgroundColor,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  flex: 12,
                  child: product.image.isEmpty
                      ? Ink(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8)),
                              image: DecorationImage(
                                image: AssetImage("assets/images/noimages.png"),
                                fit: BoxFit.cover,
                              )))
                      : Ink(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8)),
                              image: DecorationImage(
                                image: NetworkImage(product.image[0]),
                                fit: BoxFit.cover,
                              )))),
              Flexible(
                flex: 8,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    color: Color(0xFF0F4C75),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
