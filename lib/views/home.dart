import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qapp/controllers/resources.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final ResSourcesController _resourcesController =
      Get.put(ResSourcesController());

  void initState() {
    super.initState();
    _resourcesController.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return _resourcesController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Text('${_resourcesController.user.value.name}'),
            );
    }));
  }
}
