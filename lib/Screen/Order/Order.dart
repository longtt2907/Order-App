import 'package:demo_12_03/Screen/Order/Pay.dart';
import 'package:demo_12_03/constants.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_id/scroll_to_id.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  late ScrollToId scrollToId;
  final ScrollController scrollController = ScrollController();

  // void _scrollListener() {
  //   print(scrollToId.idPosition());
  // }

  @override
  void initState() {
    super.initState();

    /// Create ScrollToId instance
    scrollToId = ScrollToId(scrollController: scrollController);

    // scrollController.addListener(_scrollListener);
  }

  /// Generate 10 Container
  /// Case [Axis.horizontal] set buildStackHorizontal() to body
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Order',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Order"),
          centerTitle: true,
          leading: BackButton(
              color: Colors.white, onPressed: () => {Navigator.pop(context)}),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
          backgroundColor: kPrimaryColor,
          elevation: 4,
        ),
        body: buildBody(size.height),
        bottomSheet: Container(
          width: double.infinity,
          height: size.height * 0.1,
          child: Text("Hoa don"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.navigate_next),
          onPressed: () {
            scrollToId.animateToNext(
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          },
        ),
      ),
    );
  }

  Widget buildBody(double height) {
    return Row(
      children: [
        SideBarOrder(scrollToId: scrollToId),
        MainBody(scrollToId: scrollToId),
      ],
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({
    Key? key,
    required this.scrollToId,
  }) : super(key: key);

  final ScrollToId scrollToId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InteractiveScrollViewer(
        scrollToId: scrollToId,
        children: List.generate(10, (index) {
          return ScrollContent(
            id: '$index',
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.grey[800]!,
                      style: BorderStyle.solid,
                      width: 0.8),
                ),
              ),
              child: GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                ),
                children: List.generate(
                  10,
                  (index) {
                    return ItemsOrder();
                  },
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ItemsOrder extends StatelessWidget {
  const ItemsOrder({
    Key? key,
  }) : super(key: key);
  void buildPayPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Pay(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => buildPayPage(context),
      child: Center(
        child: Column(children: [
          Image.asset(
            "assets/images/noimages.png",
            width: 50,
            height: 50,
            fit: BoxFit.fitHeight,
          ),
          Flexible(
            child: Text(
              "Trà Táo Dâu",
              style: TextStyle(
                color: Colors.black,
              ),
              maxLines: 4,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
            ),
          ),
        ]),
      ),
    );
  }
}

class SideBarOrder extends StatelessWidget {
  const SideBarOrder({
    Key? key,
    required this.scrollToId,
  }) : super(key: key);

  final ScrollToId scrollToId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(10, (index) {
          return GestureDetector(
            child: Container(
              width: 100,
              height: 100,
              alignment: Alignment.center,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.white,
                      style: BorderStyle.solid,
                      width: 0.8),
                ),
                // color: Color(0xFFD67D3E),
                color: Colors.blue,
              ),
              child: Text(
                // '$index',
                "Nước ép trái cây",
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () {
              /// scroll with animation
              scrollToId.animateTo('$index',
                  duration: Duration(milliseconds: 500), curve: Curves.ease);

              /// scroll with jump
              // scrollToId.jumpTo('$index');
            },
          );
        }),
      ),
    );
  }
}
