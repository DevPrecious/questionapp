import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:qapp/constants/string_constant.dart';
import 'package:qapp/models/user_model.dart';
import 'package:http/http.dart' as http;

class ResSourcesController extends GetxController {
  var user = UserModel().obs;
  var token = ''.obs;
  RxBool isLoading = RxBool(false);

  // initState
  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  Future getUser() async {
    Box box = await Hive.openBox<String>(tokenString);
    token.value = box.get(tokenKey);
    final Uri uri = Uri.parse('http://192.168.201.187:8000/api/user');

    try {
      isLoading.value = true;
      final http.Response response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.value}',
      });

      if (response.statusCode == 200) {
        isLoading.value = false;
        var content = await json.decode(response.body);
        var data = await content['user'];
        print(data);
        user.value = UserModel.fromJson(data);
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
