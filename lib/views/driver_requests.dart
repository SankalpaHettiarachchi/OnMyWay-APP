import 'package:flutter/material.dart';

class DriverRequest extends StatefulWidget {
  const DriverRequest({super.key});

  @override
  State<DriverRequest> createState() => _DriverRequestState();
}

class _DriverRequestState extends State<DriverRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Customer Requests'),
          ],
        ),
      ),
    );
  }
}