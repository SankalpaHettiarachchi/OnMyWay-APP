import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onmyway/views/customerMap.dart';
import 'package:onmyway/views/home.dart';
import 'package:onmyway/views/login.dart';
import 'package:onmyway/views/home.dart';
import 'package:onmyway/views/addCustomer.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  runApp(const OnMyWay());
}

class OnMyWay extends StatelessWidget {
  const OnMyWay({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "OnMyWay",
      home: token == null ? const Login() : const Home(),
      // home: Customer(),
    );
  }
}
