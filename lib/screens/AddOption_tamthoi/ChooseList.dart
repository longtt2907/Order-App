import 'dart:developer';

import "package:flutter/material.dart";

import '../../constants.dart';
import '../../models/product_model.dart';

// Multi Select widget
// This widget is reusable
class MultiSelect extends StatefulWidget {
  final List<Product> items;
  final List<Product> selectedItems;
  final Function(List<Product>) onChanged;
  const MultiSelect(
      {Key? key,
      required this.selectedItems,
      required this.items,
      required this.onChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  // final List<String> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(Product itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        widget.selectedItems.add(itemValue);
        log('$widget.selectedItems');
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
          .map(
            (item) => Theme(
              data: ThemeData(
                  // checkboxTheme: CheckboxThemeData(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(100),
                  //   ),
                  // ),
                  ),
              child: CheckboxListTile(
                contentPadding: EdgeInsets.all(0),
                value: widget.selectedItems.contains(item),
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item.title}",
                        style: TextStyle(
                            fontSize: size.width * 0.05,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        "${item.prices[0].price}đ",
                        style: TextStyle(
                          fontSize: size.width * 0.05,
                        ),
                      ),
                    ]),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                controlAffinity: ListTileControlAffinity.leading,
                tileColor: kPrimaryColor,
                selectedTileColor: kPrimaryColor,
                activeColor: kPrimaryColor,
                onChanged: (isChecked) => _itemChange(item, isChecked!),
              ),
            ),
          )
          .toList(),
    );
  }
}
