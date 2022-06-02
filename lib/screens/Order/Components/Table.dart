import "package:flutter/material.dart";

import '../../../constants.dart';

class TableOrder extends StatelessWidget {
  const TableOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 15);
    return Container(
      padding: EdgeInsets.all(20),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
        ),
        children: List.generate(
          3,
          (index) => Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Column(children: [
              Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.blue,
                ),
                padding: padding,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Table 1"),
                    Text("15.000d"),
                  ],
                ),
              ),
              Expanded(
                child: Ink(
                  padding: padding,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: kPrimaryColor,
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
