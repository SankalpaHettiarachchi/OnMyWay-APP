import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:onmyway/constants/constants.dart';

class ServiceController extends GetxController 
{
  final isLoading = false.obs;
  final token = ''.obs;
  final box = GetStorage();

  Future addService({
    required String vehicle_id,
    required String start,
    required String destination,
    required String current,
    required String status,
  })
   async {
    try {
      isLoading.value = true;
      var data = {
        'vehicle_id': vehicle_id,
        'start': start,
        'destination': destination,
        'current': current,
        'status': status,
      };

      var response = await http.post(
        Uri.parse(url + 'save_service'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
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