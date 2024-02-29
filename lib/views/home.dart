import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onmyway/views/driver.dart';
import 'package:onmyway/views/customer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Select Role'),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const Driver());
                },
                child: const Text("Driver")
              ),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const Customer());
                },
                child: const Text("Customer")
              ),
          ],
        ),
      ),
    );
  }
}