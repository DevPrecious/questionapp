import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:qapp/constants/string_constant.dart';
import 'package:qapp/models/post_model.dart';
import 'package:qapp/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:qapp/views/feed.dart';

class ResSourcesController extends GetxController {
  var user = UserModel().obs;
  Rx<List<PostModel>> postsdata = Rx<List<PostModel>>([]);
  var token = ''.obs;
  RxBool isLoading = RxBool(false);

  // initState
  @override
  void onInit() {
    super.onInit();
    getUser();
    getPosts();
  }

  Future getUser() async {
    Box box = await Hive.openBox<String>(tokenString);
    token.value = box.get(tokenKey);
    final Uri uri = Uri.parse('${url}user');

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

  Future getPosts() async {
    Box box = await Hive.openBox<String>(tokenString);
    token.value = box.get(tokenKey);
    final Uri uri = Uri.parse('${url}posts');
    try {
      postsdata.value.clear();
      isLoading.value = true;
      final http.Response response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.value}',
      });
      if (json.decode(response.body)['success'] == true) {
        isLoading.value = false;
        var content = await json.decode(response.body);
        var data = await content['posts'] as List;
        print(data.length);
        for (var item in data) {
          postsdata.value.add(PostModel.fromJson(item));
        }
      } else {
        print(response.body);
        isLoading.value = false;
        postsdata.value = [];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void makePost({required String content}) async {
    Box box = await Hive.openBox<String>(tokenString);
    token.value = box.get(tokenKey);
    final Uri uri = Uri.parse('${url}store');

    var data = {'content': content};

    try {
      isLoading.value = true;
      var response = await http.post(uri, body: json.encode(data), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.value}',
      });
      if (json.decode(response.body)['success'] == true) {
        isLoading.value = false;
        Get.snackbar(
          'Success',
          'Post Created',
          snackPosition: SnackPosition.TOP,
        );
        Get.off(() => FeedPage());
      } else {
        isLoading.value = false;
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
