// ignore: file_names
import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:qapp/constants/string_constant.dart';
import 'package:qapp/views/home.dart';

class AuthController extends GetxController {
  RxBool isLoading = RxBool(false);

  void RegisterUser({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    const url = 'http://192.168.201.187:8000/api/register';
    final Uri uri = Uri.parse(url);

    var data = {
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    };

    try {
      isLoading.value = true;
      var response = await http.post(
        uri,
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 201) {
        isLoading.value = false;
        Box box = await Hive.openBox<String>(tokenString);
        await box.put(tokenKey, json.decode(response.body)['token']);
        Get.offAll(() => FeedPage());
        // print(response.body);

      } else {
        isLoading.value = false;
        print(response.statusCode);
        print(response.body);
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      isLoading.value = false;

      print(e.toString());
    }
  }
}
