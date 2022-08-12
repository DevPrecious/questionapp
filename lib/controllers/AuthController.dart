// ignore: file_names
import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:qapp/constants/string_constant.dart';
import 'package:qapp/views/feed.dart';

class AuthController extends GetxController {
  RxBool isLoading = RxBool(false);

  void RegisterUser({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    final Uri uri = Uri.parse('${url}register');

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
        Get.offAll(() => const FeedPage());
        // print(response.body);

      } else {
        isLoading.value = false;
        // print(response.statusCode);
        // print(response.body);
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

  void LoginUser({
    required String email,
    required String password,
  }) async {
    final Uri uri = Uri.parse('${url}login');

    var data = {
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

      if (json.decode(response.body)['success'] == true) {
        isLoading.value = false;
        Box box = await Hive.openBox<String>(tokenString);
        await box.put(tokenKey, json.decode(response.body)['token']);
        Get.offAll(() => const FeedPage());
      } else {
        isLoading.value = false;
        // print(response.statusCode);
        // print(response.body);
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
