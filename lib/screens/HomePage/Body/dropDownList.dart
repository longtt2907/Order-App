import "package:flutter/material.dart";

class DropDownList extends StatelessWidget {
  final List<String> items;
  final String itemChoosed;
  final Function(String?) onChanged;
  const DropDownList({
    Key? key,
    required this.items,
    required this.itemChoosed,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: itemChoosed,
          items: items
              .map(
                (e) => DropdownMenuItem(
                  child: Text(e,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  value: e,
                ),
              )
              .toList(),
          onChanged: (String? val) => {onChanged(val)},
        ),
      ),
    );
  }
}
