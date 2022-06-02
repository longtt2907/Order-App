import 'dart:developer';

import "package:flutter/material.dart";

import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/models/product_model.dart';

// Multi Select widget
// This widget is reusable
class MultiSelected extends StatefulWidget {
  final List<Product> items;
  final List<Product> selectedItems;
  final Function(List<Product>) onChanged;
  const MultiSelected(
      {Key? key,
      required this.selectedItems,
      required this.items,
      required this.onChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectedState();
}

class _MultiSelectedState extends State<MultiSelected> {
  // this variable holds the selected items
  // final List<String> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(Product itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        widget.selectedItems.add(itemValue);
      } else {
        widget.selectedItems.remove(itemValue);
      }
      widget.onChanged(widget.selectedItems as List<Product>);
      log('${widget.selectedItems}');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.items
            .map((Product item) => Container(
                width: double.infinity,
                height: 40,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${item.title}",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                          overflow: TextOverflow.ellipsis),
                    ),
                    GestureDetector(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          height: 32,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: widget.selectedItems.contains(item)
                                  ? kBlackColor
                                  : Colors.white,
                              border: Border.all(
                                  color: Colors.black54,
                                  style: BorderStyle.solid,
                                  width: 1.0)),
                          child: Row(
                            children: [
                              widget.selectedItems.contains(item)
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  : Icon(
                                      Icons.add_outlined,
                                      color: Colors.black54,
                                      size: 20,
                                    ),
                              // SizedBox(width: 4),
                              // Text(
                              //   "Add",
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.w700,
                              //       color: widget.selectedItems.contains(item)
                              //           ? Colors.white
                              //           : Colors.black54),
                              // ),
                            ],
                          ),
                        ),
                        onTap: () {
                          _itemChange(
                              item, !widget.selectedItems.contains(item));
                        }),
                  ],
                )))
            .toList());
  }
}
