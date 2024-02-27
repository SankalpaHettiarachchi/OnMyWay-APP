import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/register.dart';
import 'views/login.dart';

void main() {
  runApp(const OnMyWay());
}

class OnMyWay extends StatelessWidget
{
  const OnMyWay({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: "OnMyWay",
  //     home: Scaffold(
  //       appBar: AppBar(
  //            title: const Text("OnMyWay"),
  //            backgroundColor: Colors.blueAccent,
  //       ),
  //     ),
  //   );
  // }

    @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "OnMyWay",
      home: FormExampleApp(),
    );
  }
}