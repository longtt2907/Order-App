// ignore_for_file: prefer_const_constructors

import 'package:demo_12_03/Screen/AddOption/Add_options.dart';
import 'package:demo_12_03/Screen/AddFood/components/PickingImg.dart';
import 'package:demo_12_03/components/input_container.dart';
import 'package:demo_12_03/components/round_button.dart';
import 'package:demo_12_03/components/round_prefix_icon_button.dart';
import 'package:demo_12_03/components/text_input_field.dart';
import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/controllers/category_controller.dart';
import 'package:demo_12_03/controllers/product_controller.dart';
import 'package:demo_12_03/models/category_model.dart';
import 'package:demo_12_03/models/product_model.dart';
import "package:flutter/material.dart";
import 'package:uuid/uuid.dart';

class AddFood extends StatelessWidget {
  final Product? product;
  const AddFood({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Thêm món ăn"),
          centerTitle: true,
          leading: BackButton(
              color: Colors.white, onPressed: () => {Navigator.pop(context)}),
          backgroundColor: kPrimaryColor,
          elevation: 4,
        ),
        body: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: size.height),
          child: InfoContainer(product: product),
        ));
  }
}

class DanhMuc {
  final String? tenDMuc;
  const DanhMuc({this.tenDMuc});
}

class InfoContainer extends StatefulWidget {
  final Product? product;
  const InfoContainer({
    Key? key,
    this.product,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddFoodState();
}

class _AddFoodState extends State<InfoContainer> {
  CategoryService categoryService = CategoryService();
  ProductService productService = ProductService();
  List<Category> listCategory = [];
  late String title = "";
  late String? categoryId;
  late List<dynamic> image = [];
  late String unit = "";
  late List<dynamic> prices = [];
  late int quantity = 0;
  late bool isLinked = false;
  late String? linkedCategory;

  late String titlePriceInput = "";
  late String priceInput = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      categoryId = null;
      linkedCategory = null;
    });
    if (widget.product != null) {
      _initialValue();
    }
  }

  _initialValue() {
    title = widget.product!.title;
    categoryId = widget.product!.category;
    image = widget.product!.image;
    unit = widget.product!.unit;
    prices = widget.product!.prices;
    quantity = widget.product!.quantity;
    isLinked = widget.product!.isLinked;
    linkedCategory = widget.product!.linkedCategory;
  }

  void handleIsLinked(bool val) {
    if (val == false) {
      setState(() {
        linkedCategory = null;
      });
    }
    setState(() {
      isLinked = val;
    });
  }

  void addPrice() {
    if (titlePriceInput != "" && int.parse(priceInput) > 0) {
      Price price = Price(
          id: Uuid().v1(),
          title: titlePriceInput,
          price: int.parse(priceInput));
      setState(() {
        prices.add(price);
        titlePriceInput = "";
        priceInput = "";
      });
    } else {
      print("Nhập đi");
    }
  }

  void handleDeletePrice(String priceId) {
    setState(() {
      prices.removeWhere((price) => price.id == priceId);
    });
  }

  void handleSubmit() {
    Product newProduct = Product(
      title: title,
      category: categoryId as String,
      image: image,
      unit: unit,
      prices: prices,
      quantity: quantity,
      isLinked: isLinked,
      linkedCategory: linkedCategory,
    );

    productService.createProduct(newProduct).then((result) {
      Navigator.pop(context, result);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: categoryService.getCategories(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
          if (snapshot.hasData) {
            listCategory = snapshot.data!;

            return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 5, top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 20,
                                  offset: Offset(0, 0))
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: [
                              image.isNotEmpty
                                  ? PickingImg(
                                      image: image.first,
                                      callback: (val) {
                                        setState(() {
                                          image = [val];
                                        });
                                      })
                                  : PickingImg(callback: (val) {
                                      setState(() {
                                        image = [val];
                                      });
                                    }),
                              Text("Nhấp vào để chọn hình ảnh"),
                              InputContainer(
                                  child: RoundedInputField(
                                      onChanged: (val) {
                                        setState(() {
                                          title = val;
                                        });
                                      },
                                      initialValue: title,
                                      hintText: 'Món ăn',
                                      icon: Icons.title)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    flex: 4,
                                    child: InputContainer(
                                        child: RoundedInputField(
                                            onChanged: (val) {
                                              setState(() {
                                                titlePriceInput = val;
                                              });
                                            },
                                            hintText: 'Size',
                                            icon: Icons.book)),
                                  ),
                                  const SizedBox(width: 10),
                                  Flexible(
                                    flex: 4,
                                    child: InputContainer(
                                        child: RoundedInputField(
                                            onChanged: (val) {
                                              setState(() {
                                                priceInput = val;
                                              });
                                            },
                                            isNumber: true,
                                            hintText: 'Giá',
                                            icon: Icons.price_check)),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.send),
                                    onPressed: () {
                                      addPrice();
                                    },
                                  )
                                ],
                              ),
                              prices.isNotEmpty
                                  ? showListPrice()
                                  : SizedBox(height: 0),
                              const SizedBox(height: 10)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 5, top: 5),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 20,
                                    offset: Offset(0, 0))
                              ]),
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(children: [
                            InputContainer(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    items: [
                                      ...listCategory.map((category) {
                                        return DropdownMenuItem(
                                            child: Text(category.name),
                                            value: category.id);
                                      }).toList()
                                    ],
                                    onChanged: (String? val) {
                                      setState(() {
                                        categoryId = val;
                                        linkedCategory = null;
                                      });
                                      // print(val);
                                    },
                                    hint: Text("Choose Category"),
                                    isExpanded: true,
                                    value: categoryId),
                              ),
                            ),
                            InputContainer(
                              child: TapInputField(
                                  initialValue: unit,
                                  hintText: "Đơn vị",
                                  onChanged: (val) {
                                    setState(() {
                                      unit = val;
                                    });
                                  }),
                            ),
                            InputContainer(
                              child: TapInputField(
                                  initialValue: quantity.toString(),
                                  hintText: "Số lượng",
                                  onChanged: (val) {
                                    setState(() {
                                      quantity = int.parse(val);
                                    });
                                  }),
                            ),
                          ])),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 5, top: 5),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 20,
                                    offset: Offset(0, 0))
                              ]),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Liên kết kho"),
                                  Switch(
                                    value: isLinked,
                                    onChanged: handleIsLinked,
                                    inactiveTrackColor: Colors.grey[200],
                                    activeColor: kPrimaryColor,
                                  )
                                ],
                              ),
                              InputContainer(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                      items: [
                                        ...listCategory
                                            .where((e) => e.id != categoryId)
                                            .map((category) {
                                          return DropdownMenuItem(
                                              child: Text(category.name),
                                              value: category.id);
                                        }).toList()
                                      ],
                                      onChanged: isLinked
                                          ? (String? val) => setState(
                                              () => linkedCategory = val)
                                          : null,
                                      hint: Text("Choose Category"),
                                      isExpanded: true,
                                      value: linkedCategory),
                                ),
                              )
                            ],
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 20),
                      width: size.width * 0.6,
                      height: 50,
                      child: RoundPrefixIconButton(
                          text: 'Thêm món ăn',
                          icon: Icon(Icons.check, color: kPrimaryColor),
                          color: kPrimaryColor,
                          textColor: Colors.white,
                          press: () {
                            handleSubmit();
                          }),
                    ),
                  ]),
                ));
          }

          return Center(child: CircularProgressIndicator());
        });
  }

  Widget showListPrice() {
    return Column(
        children: prices.map((price) {
      return rowPrice(price);
    }).toList());
  }

  Widget rowPrice(price) {
    return Dismissible(
        key: Key(price.id),
        onDismissed: (direction) {
          handleDeletePrice(price.id);
        },
        direction: DismissDirection.endToStart,
        background: deleteBgItem(),
        child: Card(
            child: ListTile(
          leading: Icon(Icons.numbers),
          title: Text(price.title),
          subtitle: Text(price.price.toString()),
          trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showEditPriceDialog(context, price);
              }),
        )));
  }

  Widget deleteBgItem() {
    return Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.all(3),
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white));
  }

  void showEditPriceDialog(context, price) {
    String newTitleInput = price.title;
    String newPriceInput = price.price.toString();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Chỉnh sửa giá"),
            content: Row(children: [
              Flexible(
                child: TextFormField(
                  initialValue: newTitleInput,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Size",
                    labelStyle: TextStyle(color: Colors.grey),
                    focusColor: kPrimaryColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                  onChanged: (val) {
                    newTitleInput = val;
                  },
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: TextFormField(
                  initialValue: newPriceInput,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Giá",
                    labelStyle: TextStyle(color: Colors.grey),
                    focusColor: kPrimaryColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                  onChanged: (val) {
                    newPriceInput = val;
                  },
                ),
              ),
            ]),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Hủy"),
              ),
              FlatButton(
                  textColor: Colors.green,
                  onPressed: () {
                    Price newPrice = Price(
                        id: price.id,
                        title: newTitleInput,
                        price: int.parse(newPriceInput));

                    int index = prices.indexWhere((e) => e.id == newPrice.id);

                    setState(() {
                      prices.removeAt(index);
                      prices.insert(index, newPrice);
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("Sửa")),
            ],
          );
        });
  }
}

class TapInputField extends StatelessWidget {
  final String? value;
  final String? hintText;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  const TapInputField({
    Key? key,
    this.value,
    this.hintText,
    required this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            suffixIcon: Icon(Icons.arrow_circle_right, color: kPrimaryColor)));
  }
}
