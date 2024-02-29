import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:onmyway/constants/constants.dart';
import 'package:onmyway/views/home.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final box = GetStorage();

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

  Future login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'username': email,
        'password': password,
      };

      var response = await http.post(
        Uri.parse(url + 'login'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        debugPrint(response.body);
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Get.offAll(() => const Home());
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
