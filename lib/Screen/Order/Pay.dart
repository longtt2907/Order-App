import 'dart:developer';

import 'package:demo_12_03/Screen/AddOption_tamthoi/AddOption_main.dart';
import 'package:demo_12_03/components/round_button.dart';
import 'package:demo_12_03/constants.dart';
import "package:flutter/material.dart";

import '../../components/radio_button.dart';

class Pay extends StatelessWidget {
  const Pay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Pay"),
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
        body: Container(
          width: double.infinity,
          height: size.height,
          color: Colors.grey,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.7,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InfoPay(size: size),
                      const SizedBox(height: 20),
                      DetailPay(size: size),
                      const SizedBox(height: 20),
                      NotePay(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ConfirmPay(size: size),
            ],
          ),
        ));
  }
}

class ConfirmPay extends StatefulWidget {
  const ConfirmPay({
    Key? key,
    required this.size,
  }) : super(key: key);
  final Size size;

  @override
  State<ConfirmPay> createState() => _ConfirmPayState();
}

class _ConfirmPayState extends State<ConfirmPay> {
  int i = 1; // đếm số lượng
  void subtract() {
    if (i > 1) {
      setState(() {
        i = --i;
      });
    }
  }

  void add() {
    setState(() {
      i = ++i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Số lượng: ", style: TextStyle(fontSize: 15)),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kPrimaryColor)),
                            child: Text("-",
                                style: TextStyle(color: Colors.white)),
                            onPressed: () => subtract(),
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            width: 30,
                            height: 30,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                    style: BorderStyle.solid)),
                            child: Text("${i}")),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kPrimaryColor)),
                            child: Text("+",
                                style: TextStyle(color: Colors.white)),
                            onPressed: () => add(),
                          ),
                        ),
                        // TextField(
                        //   keyboardType: TextInputType.number,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: widget.size.width * 0.2,
              child: RoundButton(
                  text: 'Hoàn tất',
                  color: kPrimaryColor,
                  textColor: Colors.white,
                  press: () {}),
            ),
          ],
        ),
      ),
    );
  }
}

class NotePay extends StatelessWidget {
  const NotePay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Ghi chú",
          ),
          maxLines: 4,
        ));
  }
}

class DetailPay extends StatelessWidget {
  const DetailPay({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(15),
      ),
      // height: size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text("topping",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          // ignore: prefer_const_literals_to_create_immutables, prefer_const_constructors
          ChooseOption(danhmuc: [
            "tran chau den",
            "tran chau trang",
            "banh plan",
            "kem cheese"
          ]),
        ],
      ),
    );
  }
}

class InfoPay extends StatelessWidget {
  const InfoPay({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(15),
      ),
      // height: size.height * 0.3,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/images/noimages.png",
                width: 100,
                height: 100,
                fit: BoxFit.fitWidth,
              ),
              Text(
                "Trà Táo Dâu",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(
            thickness: 1.0,
          ),
          Center(child: ChooseOption(danhmuc: ['15,000', '28,000'])),
        ],
      ),
    );
  }
}
