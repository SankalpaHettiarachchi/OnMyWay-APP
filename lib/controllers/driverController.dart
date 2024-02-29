import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:onmyway/constants/constants.dart';
import 'package:get_storage/get_storage.dart';

class DriverController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final box = GetStorage();

  Future saveDriver({
    required String Vehicle_no,
    required String License_no,
  })
   async {
    try {
      isLoading.value = true;
      var data = {
        'vehicle_id': Vehicle_no,
        'license_id': License_no,
      };

      var response = await http.post(
        Uri.parse(url + 'save_driver'),
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
