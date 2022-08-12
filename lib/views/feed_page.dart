import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qapp/controllers/resources.dart';
import 'package:qapp/views/widgets/post_widget.dart';
import 'package:qapp/views/widgets/user_bar.dart';

class FeedPgaeR extends StatefulWidget {
  const FeedPgaeR({Key? key}) : super(key: key);

  @override
  State<FeedPgaeR> createState() => _FeedPgaeRState();
}

class _FeedPgaeRState extends State<FeedPgaeR> {
  final ResSourcesController _resourcesController =
      Get.put(ResSourcesController());

  void initState() {
    super.initState();
    // _resourcesController.getUser();
    // _resourcesController.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(
                () {
                  return _resourcesController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : UserBar(resourcesController: _resourcesController);
                },
              ),
              const SizedBox(height: 15),
              const Divider(),
              const SizedBox(height: 15),
              Obx(() {
                final snapshot = _resourcesController.postsdata.value;
                return _resourcesController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.length,
                            // physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return PostWidget(
                                postModel: snapshot[index],
                              );
                            }),
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
