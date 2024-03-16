import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:onmyway/controllers/serviceController.dart';
import 'package:onmyway/views/driverMap.dart';
import './widgets/InputWidget.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final ServiceController _serviceController = ServiceController();
  final TextEditingController _vehicleIdController  = TextEditingController();
  final TextEditingController _startController  = TextEditingController();
  final TextEditingController _destinationController  = TextEditingController();
  final TextEditingController _currentController  = TextEditingController();
  final TextEditingController _stateController  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Service Information'),
            const SizedBox(
              height: 10,
            ),
            InputWidget(
              hintText: 'Vehicle ID',
              controller: _vehicleIdController,
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            InputWidget(
              hintText: 'Start',
              controller: _startController,
              obscureText: false,
            ),
            InputWidget(
              hintText: 'Destination',
              controller: _destinationController,
              obscureText: false,
            ),
            InputWidget(
              hintText: 'Currernt Position',
              controller: _currentController,
              obscureText: false,
            ),
            InputWidget(
              hintText: 'State',
              controller: _stateController,
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() {
              return _serviceController.isLoading.value ? const CircularProgressIndicator() : ElevatedButton(
                      onPressed: () async {
                        await _serviceController.addService(
                          vehicle_id: _vehicleIdController.text.trim(),
                          start: _startController.text.trim(),
                          destination: _destinationController.text.trim(),
                          current: _currentController.text.trim(),
                          status: _stateController.text.trim(),
                          );
                      },
                      child: const Text("Save Service")
                    );
            }),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const DriverMap());
                },
                child: const Text("Driver-Map")),
          ],
        ),
      ),
    );
  }
}
