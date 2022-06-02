// ignore_for_file: deprecated_member_use

import 'package:demo_12_03/screens/AddOption_tamthoi/ChooseList.dart';
import 'package:demo_12_03/components/round_button.dart';
import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/controllers/category_controller.dart';
import 'package:demo_12_03/models/category_model.dart';
import 'package:flutter/material.dart';

class AddOptionMain extends StatefulWidget {
  const AddOptionMain({Key? key}) : super(key: key);

  @override
  State<AddOptionMain> createState() => _AddOptionMainState();
}

class _AddOptionMainState extends State<AddOptionMain> {
  final CategoryService categoryService = CategoryService();
  List<String> danhmucSelected = [];
  List<Category> listCategory = [];

  void themDanhMuc(String nameCate) {
    categoryService.createCategory(nameCate).then((result) {
      setState(() {
        listCategory.add(result);
      });
    });
    Navigator.pop(context);
  }

  void xoaDanhMuc(String categoryId) {
    categoryService.deleteCategory(categoryId).then((result) {
      setState(() {
        listCategory.removeWhere((cate) => cate.id == categoryId);
      });
    });
  }

  void suaDanhMuc(Category category) {
    categoryService.updateCategory(category).then((result) {
      setState(() {
        int index =
            listCategory.indexWhere((category) => category.id == result.id);
        listCategory.removeAt(index);
        listCategory.insert(index, result);
      });
    });
    Navigator.pop(context);
  }

  void openDialog(context) {
    String itemValue = '';
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Thêm danh mục"),
            content: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Tên danh mục",
                labelStyle: TextStyle(color: Colors.grey),
                focusColor: kPrimaryColor,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
              ),
              onChanged: (value) {
                itemValue = value;
              },
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Hủy"),
              ),
              FlatButton(
                  textColor: kPrimaryColor,
                  onPressed: () => themDanhMuc(itemValue),
                  child: const Text("Tạo mới")),
            ],
          );
        });
  }

  Widget showListCategory() {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: listCategory.length,
      itemBuilder: (BuildContext context, int index) {
        return rowItem(context, index);
      },
    );
  }

  Widget rowItem(context, index) {
    return Dismissible(
        key: Key(listCategory[index].id),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          return await confirmDismiss(context);
        },
        onDismissed: (direction) {
          xoaDanhMuc(listCategory[index].id);
        },
        background: deleteBgItem(),
        child: Card(
          child: TextButton(
            style: ButtonStyle(
                alignment: Alignment.centerLeft,
                padding: MaterialStateProperty.all(EdgeInsets.zero)),
            onPressed: () {
              showUpdateDialog(context, listCategory[index]);
            },
            child: ListTile(title: Text(listCategory[index].name)),
          ),
        ));
  }

  void showUpdateDialog(context, category) {
    String newName = category.name;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Chỉnh sửa danh mục"),
              content: TextFormField(
                  initialValue: newName,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Tên danh mục",
                      labelStyle: TextStyle(color: Colors.grey),
                      focusColor: kPrimaryColor,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor))),
                  onChanged: (val) {
                    newName = val;
                  }),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Hủy")),
                FlatButton(
                    textColor: Colors.green[400],
                    onPressed: () {
                      Category newCategory =
                          Category(id: category.id, name: newName);

                      suaDanhMuc(newCategory);
                    },
                    child: const Text("Xác nhận"))
              ]);
        });
  }

  Future<bool> confirmDismiss(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Xác nhận"),
          content: const Text("Bạn có chắc muốn xóa danh mục này?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Hủy"),
            ),
            FlatButton(
                textColor: Colors.red,
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Xóa")),
          ],
        );
      },
    );
  }

  Widget deleteBgItem() {
    return Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.all(3),
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Thêm món ăn", style: TextStyle(color: kBlackColor)),
          leading: BackButton(
              color: kBlackColor,
              onPressed: () {
                Navigator.pop(context, danhmucSelected);
              }),
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            openDialog(context);
          },
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.add),
        ),
        body: FutureBuilder(
            future: categoryService.getCategories(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
              if (snapshot.hasData) {
                listCategory = snapshot.data!;

                return Container(
                    width: double.infinity,
                    height: size.height,
                    child: Column(
                      children: [
                        Expanded(
                          child: showListCategory(),
                        ),
                      ],
                    ));
              }

              return const Center(child: CircularProgressIndicator());
            }));
  }
}

class RoundedButton extends StatelessWidget {
  final String hintText;
  final Function onPressed;
  const RoundedButton({
    Key? key,
    required this.hintText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
              Size(size.width * 0.6, size.width * 0.10)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              side: BorderSide(
                  color: Color.fromARGB(255, 192, 190, 190),
                  style: BorderStyle.solid))),
        ),
        child: Text(hintText, style: TextStyle(color: kPrimaryLightColor)),
        onPressed: onPressed());
  }
}
