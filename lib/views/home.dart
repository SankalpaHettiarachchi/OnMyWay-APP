import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onmyway/controllers/authenticationController.dart';
import 'package:onmyway/views/customer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthenticationController _authenticationController =
      AuthenticationController();

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
            Obx(() {
              return _authenticationController.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        await _authenticationController.driverAuthentcation();
                      },
                      child: const Text("Driver"));
            }),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const Customer());
                },
                child: const Text("Customer")),
          ],
        ),
      ),
    );
  }
}
