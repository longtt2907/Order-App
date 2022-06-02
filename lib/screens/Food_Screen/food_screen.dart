import 'package:demo_12_03/screens/AddFood/AddFood.dart';
import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/controllers/category_controller.dart';
import 'package:demo_12_03/controllers/product_controller.dart';
import 'package:demo_12_03/models/category_model.dart';
import 'package:demo_12_03/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_id/scroll_to_id.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final CategoryService categoryService = CategoryService();
  final ProductService productService = ProductService();
  late ScrollToId scrollToId;
  final ScrollController scrollController = ScrollController();
  List<Product> listProducts = [];
  List<Category> listCategory = [];
  String selectedCategory = "";
  List listText = [];

  @override
  void initState() {
    super.initState();

    scrollToId = ScrollToId(scrollController: scrollController);
  }

  handleSelectCategory(String cateId) {
    setState(() {
      selectedCategory = cateId;
    });
    scrollToId.animateTo(cateId,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  _handleFood(Product food) {
    print(listProducts.length);
    setState(() {
      listProducts = [...listProducts, food];
    });
    print(listProducts.length);

    // print(food);
  }

  _navigateToProductDetailPage(BuildContext context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddFood(handleFood: _handleFood)));
  }

  Widget buildBody() {
    return Expanded(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[_sidebarFood(), showListFood()]),
    );
  }

  Widget _sidebarFood() {
    return Expanded(
      flex: 0,
      child: SingleChildScrollView(
          child: Column(
              children: listCategory.map((category) {
        return Container(
          margin: EdgeInsets.only(bottom: 15),
          child: RotatedBox(
            quarterTurns: 3,
            child: TextButton(
              style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all(kPrimaryColor.withOpacity(0.1)),
              ),
              onPressed: () => handleSelectCategory(category.id),
              child: Column(
                children: [
                  Text(category.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: selectedCategory == category.id
                              ? kPrimaryColor
                              : Color(0xFFD4D4D4))),
                  selectedCategory == category.id
                      ? Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.all(3),
                          decoration: new BoxDecoration(
                            color: Color(0xFF51CBA2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(left: 5),
                          padding: EdgeInsets.all(2),
                        )
                ],
              ),
            ),
          ),
        );
      }).toList())),
    );
  }

  Widget showListFood() {
    return Expanded(
        child: InteractiveScrollViewer(
            scrollToId: scrollToId,
            children: listCategory.map((category) {
              return ScrollContent(
                  id: category.id,
                  child: GridView.builder(
                      padding: listCategory.indexOf(category) > 0
                          ? const EdgeInsets.fromLTRB(10, 20, 2, 10)
                          : const EdgeInsets.fromLTRB(10, 10, 2, 10),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.78,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                      ),
                      itemCount: listProducts
                          .where((product) => product.category == category.id)
                          .toList()
                          .length,
                      itemBuilder: (BuildContext context, index) {
                        return foodItem(listProducts
                            .where((product) => product.category == category.id)
                            .toList()[index]);
                      }));
            }).toList()));
  }

  Widget foodItem(product) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(1, 2))
            ]),
        child: TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            overlayColor: MaterialStateProperty.all(
              kPrimaryColor.withOpacity(0.1),
            ),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddFood(product: product, handleFood: _handleFood)));
          },
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 4,
                    child: product.image.isEmpty
                        ? Ink(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/noimages.png"),
                                  fit: BoxFit.cover,
                                )))
                        : Ink(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                image: DecorationImage(
                                  image: NetworkImage(product.image[0]),
                                  fit: BoxFit.contain,
                                )))),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(product.title,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF7E7E7E))),
                    )),
              ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý món ăn"),
        centerTitle: true,
        leading: BackButton(
            color: Colors.white, onPressed: () => {Navigator.pop(context)}),
        backgroundColor: kPrimaryColor,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Container(
            width: double.infinity,
            height: double.infinity,
            child: FutureBuilder(
                future: categoryService.getCategories(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Category>> snapshot) {
                  if (snapshot.hasData) {
                    listCategory =
                        listCategory.isNotEmpty ? listCategory : snapshot.data!;

                    return Column(children: [
                      FutureBuilder(
                          future: productService.getProducts(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Product>> snapshot) {
                            if (snapshot.hasData) {
                              listProducts = listProducts.isNotEmpty
                                  ? listProducts
                                  : snapshot.data!;
                              selectedCategory = selectedCategory.isNotEmpty
                                  ? selectedCategory
                                  : listCategory[0].id;

                              return buildBody();
                            }

                            return const Center(
                                child: CircularProgressIndicator());
                          })
                    ]);
                  }

                  return const Center(child: CircularProgressIndicator());
                })),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          _navigateToProductDetailPage(context);
        },
      ),
    );
  }
}
