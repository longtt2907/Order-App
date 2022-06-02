import 'package:demo_12_03/components/round_prefix_icon_button.dart';
import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/models/bill_model.dart';
import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  final ScrollController scrollController;
  final Bill? bill;
  // final Future<ValueChanged> onPressed;
  const TabWidget({
    Key? key,
    required this.scrollController,
    required this.bill,
    // required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
        controller: scrollController,
        children: [_topWidget(), _contentWidget()]);
  }

  Widget _topWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("${numFormat.format(bill!.totalPrice)}đ",
            style: TextStyle(
                fontSize: 20,
                color: kPrimaryColor,
                fontWeight: FontWeight.w500)),
        Text("Mặt hàng: ${bill!.dishes.length}",
            style: TextStyle(fontWeight: FontWeight.w600))
      ]),
      RoundPrefixIconButton(
          press: () {},
          text: "Giỏ hàng",
          icon: Icon(Icons.shopping_bag_outlined, color: kPrimaryColor),
          color: kPrimaryColor,
          textColor: Colors.white)
    ]);
  }

  Widget _contentWidget() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: ListView.separated(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: bill!.dishes.length,
            itemBuilder: (BuildContext context, int index) {
              return _foodItem(bill!.dishes[index]);
            },
            separatorBuilder: (context, index) => SizedBox(height: 16)),
      ),
    );
  }

  Widget _foodItem(dish) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(14)),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Flexible(
          child: Row(children: [
            Image(
              width: 80,
              image: NetworkImage(dish.dish.image[0]),
            ),
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${dish.dish.title}  -  ${dish.size}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              SizedBox(height: 5),
              Text(
                  dish.subDish.isNotEmpty
                      ? dish.subDish.map((item) => item.title).join(', ')
                      : "",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              SizedBox(height: 10),
              Text("${numFormat.format(dish.totalPrice)}đ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
            ]),
          ]),
        ),
        Container(
          width: 50,
          child: RichText(
              text:
                  TextSpan(style: TextStyle(color: Colors.black54), children: [
            TextSpan(text: "SL: "),
            TextSpan(
                text: dish.quantity.toString(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
          ])),
        ),
      ]),
    );
  }
}
