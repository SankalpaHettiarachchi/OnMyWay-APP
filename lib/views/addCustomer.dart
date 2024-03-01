import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:onmyway/controllers/customerController.dart';
import './widgets/InputWidget.dart';

class Customer extends StatefulWidget {
  const Customer({super.key});

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  final CustomerController _customerController = CustomerController();

  final TextEditingController _cargoTypeController = TextEditingController();
  final TextEditingController _avgWeightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Customer Information'),
            const SizedBox(
              height: 10,
            ),
            InputWidget(
              hintText: 'Cargo Type',
              controller: _cargoTypeController,
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            InputWidget(
              hintText: 'Average Weight',
              controller: _avgWeightController,
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() {
              return _customerController.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        await _customerController.saveCustomer(
                          cargoType: _cargoTypeController.text.trim(), 
                          avgWeight: _avgWeightController.text.trim());
                      },
                      child: const Text("Save Customer")
                    );
            }),
          ],
        ),
      ),
    );
  }
}
