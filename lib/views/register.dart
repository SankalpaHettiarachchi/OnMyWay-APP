import 'package:flutter/material.dart';
import 'package:onmyway/views/login.dart';
import './widgets/InputWidget.dart';
import 'package:get/get.dart';

/// Flutter code sample for [Form].

void main() => runApp(const Register());

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('OnMyWay')),
        body: const RegisterForm(),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormleState();
}
class _RegisterFormleState extends State<RegisterForm> {
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Register Form'),
            const SizedBox(
              height: 10,
            ),
            InputWidget(
              hintText: 'First Name',
              controller: _fnameController,
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            InputWidget(
              hintText: 'Last Name',
              controller: _lnameController,
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            InputWidget(
              hintText: 'Email',
              controller: _emailController,
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            InputWidget(
              hintText: 'Phone',
              controller: _phoneController,
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            InputWidget(
              hintText: 'Password',
              controller: _passwordController,
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            InputWidget(
              hintText: 'Confirm Password',
              controller: _confirmPasswordController,
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Register")),
            ElevatedButton(
                onPressed: () {
                  Get.to(()=>const Login());
                },
                child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}
