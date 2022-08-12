import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qapp/controllers/resources.dart';
import 'package:qapp/views/widgets/custom_button.dart';
import 'package:qapp/views/widgets/custom_input.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController _contentController = TextEditingController();

  final ResSourcesController _resSourcesController =
      Get.put(ResSourcesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Make a post',
                  style: GoogleFonts.workSans(
                      fontSize: 27, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                CustomInput(
                  label: 'Content',
                  controller: _contentController,
                  maxline: 6,
                ),
                const SizedBox(height: 20),
                Obx(() {
                  return _resSourcesController.isLoading.value
                      ? Center(
                          child: Text(
                            'Posting....',
                            style: GoogleFonts.workSans(
                              fontSize: 18,
                            ),
                          ),
                        )
                      : CustomButton(
                          text: 'Post',
                          onPressed: () {
                            _resSourcesController.makePost(
                              content: _contentController.text.trim(),
                            );
                            // _contentController.text = '';
                          },
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
