import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:onmyway/constants/constants.dart';
import 'dart:convert';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;

  Future register({
    required String fname,
    required String lname,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    try {

      isLoading.value = true;
      var data = {
        'fname': fname,
        'lname': lname,
        'email': email,
        'phone': phone,
        'password': password,
      };

      var response = await http.post(
        Uri.parse(url + 'register'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        debugPrint(response.body);
      } else {
        isLoading.value = false;
        debugPrint(response.body);
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }
}
