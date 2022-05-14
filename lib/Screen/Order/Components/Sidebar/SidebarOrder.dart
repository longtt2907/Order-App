import 'package:demo_12_03/constants.dart';
import "package:flutter/material.dart";
import 'package:scroll_to_id/scroll_to_id.dart';

import '../../../../server/models/category_model.dart';

class SideBarOrder extends StatelessWidget {
  const SideBarOrder({
    Key? key,
    required this.scrollToId,
    required this.categories,
  }) : super(key: key);

  final ScrollToId scrollToId;
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Color(0xFF0F4C75),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 8,
            offset: Offset(2, 0), // changes position of shadow
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
            children: categories
                .map((category) => GestureDetector(
                      child: Container(
                        width: 100,
                        height: 100,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: kBackgroundColor,
                                style: BorderStyle.solid,
                                width: 0.8),
                          ),
                          color: Color(0xFF0F4C75),
                          // color: Color.fromARGB(255, 2, 54, 96),
                        ),
                        child: Text(
                          // '$index',
                          category.name,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        /// scroll with animation
                        scrollToId.animateTo(category.id,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease);

                        /// scroll with jump
                        // scrollToId.jumpTo('$index');
                      },
                    ))
                .toList()),
      ),
    );
  }
}
