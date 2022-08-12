import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qapp/constants/string_constant.dart';
import 'package:qapp/views/feed.dart';
import 'package:qapp/views/login.dart';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await path.getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox<String>(tokenString);
  var token = Hive.box<String>(tokenString).get(tokenKey);
  Box box = await Hive.openBox<String>(tokenString);
  if (token == null) {
    runApp(
      const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Qapp',
        home: LoginPage(),
      ),
    );
  } else {
    runApp(
      const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Qapp',
        home: FeedPage(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Qapp',
      home: LoginPage(),
    );
  }
}
