import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:onmyway/constants/constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onmyway/views/findService.dart';

class CustomerController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final box = GetStorage();

  Future saveCustomer({
    required String cargoType,
    required String avgWeight,
  })
  async {
    try {
      isLoading.value = true;
      var data = {
        'cargo_type': cargoType,
        'avg_weight': avgWeight,
      };

      var response = await http.post(
        Uri.parse(url + 'save_customer'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        debugPrint(response.body);
        Get.to(() => const FindService());
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
