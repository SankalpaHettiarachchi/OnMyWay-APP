import 'package:flutter/material.dart';

class FindService extends StatefulWidget {
  const FindService({super.key});

  @override
  State<FindService> createState() => _FindServiceState();
}

class _FindServiceState extends State<FindService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Find A Serivce'),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}