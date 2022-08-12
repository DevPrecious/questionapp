import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qapp/controllers/PostController.dart';
import 'package:qapp/controllers/resources.dart';
import 'package:qapp/views/widgets/post_widget.dart';
import 'package:qapp/views/widgets/single_post.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ResSourcesController _resourcesController =
      Get.put(ResSourcesController());

  final PostController _postController = Get.put(PostController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _postController.getPersonalPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://picsum.photos/200',
                    ),
                    radius: 50,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${_resourcesController.user.value.name}',
                    style: GoogleFonts.workSans(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '@${_resourcesController.user.value.username}',
                    style: GoogleFonts.workSans(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            '30k',
                            style: GoogleFonts.workSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Total Likes',
                            style: GoogleFonts.workSans(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '50',
                            style: GoogleFonts.workSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Total Posts',
                            style: GoogleFonts.workSans(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      'My Posts',
                      style: GoogleFonts.workSans(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                final snapshot = _postController.postsdata.value;
                return _postController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.length,
                          itemBuilder: (context, index) {
                            return SinglePost(
                              postModel: snapshot[index],
                            );
                          },
                        ),
                      );
              }),
            ],
          ),
        ),
      ),
    );
    // );
  }
}
