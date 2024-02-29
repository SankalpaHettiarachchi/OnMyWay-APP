import 'package:flutter/material.dart';
import './widgets/InputWidget.dart';
import 'package:onmyway/controllers/driverController.dart';
import 'package:get/get.dart';


class Driver extends StatefulWidget {
  const Driver({super.key});

  @override
  State<Driver> createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('OnMyWay')),
        body: const DriverForm(),
      ),
    );
  }
}

class DriverForm extends StatefulWidget {
  const DriverForm({super.key});

  @override
  State<DriverForm> createState() => _DriverFormState();
}

class _DriverFormState extends State<DriverForm> 
{
  final DriverController _driverController = DriverController();
  final TextEditingController _driverNoController = TextEditingController();
  final TextEditingController _licenseNoController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Driver Information'),
            const SizedBox(
              height: 10,
            ),
            InputWidget(
              hintText: 'Vehicle No',
              controller: _licenseNoController,
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            InputWidget(
              hintText: 'License No',
              controller: _driverNoController,
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() {
              return 
              _driverController.isLoading.value ? const CircularProgressIndicator()
              :ElevatedButton(
                  onPressed: () async{
                    await _driverController.saveDriver(
                      Vehicle_no: _driverNoController.text.trim(), 
                      License_no: _licenseNoController.text.trim(),
                      );
                  },
                  child: const Text("Save Driver")
                ); 
            }),
          ],
        ),
      ),
    );
  }
}
