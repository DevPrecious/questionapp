import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:qapp/constants/string_constant.dart';
import 'package:http/http.dart' as http;
import 'package:qapp/models/user_post.dart';

class PostController extends GetxController {
  Rx<List<SinglePostModel>> postsdata = Rx<List<SinglePostModel>>([]);
  var token = ''.obs;
  RxBool isLoading = RxBool(false);

  Future getPersonalPosts() async {
    Box box = await Hive.openBox<String>(tokenString);
    token.value = box.get(tokenKey);
    final Uri uri = Uri.parse('${url}myposts');
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
          print(item);
          postsdata.value.add(SinglePostModel.fromJson(item));
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
}
