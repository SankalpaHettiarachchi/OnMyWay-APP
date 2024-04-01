import 'package:flutter/material.dart';
import 'package:onmyway/controllers/authenticationController.dart';
import 'package:onmyway/views/register.dart';
import 'package:get/get.dart';
import './widgets/InputWidget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('OnMyWay')),
        body: const LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passworcontroller = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login Form'),
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
              hintText: 'Password',
              controller: _passworcontroller,
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() {
              return
              _authenticationController.isLoading.value ? const CircularProgressIndicator()
              :ElevatedButton(
                  onPressed: () async{
                    String? errorMessage = await _authenticationController.login(
                      email: _emailController.text.trim(),
                      password: _passworcontroller.text.trim(),
                    );
                    if (errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMessage),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  },
                  child: const Text("Login"));
            }),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const Register());
                },
                child: const Text("Register")),
          ],
        ),
      ),
    );
  }
}
