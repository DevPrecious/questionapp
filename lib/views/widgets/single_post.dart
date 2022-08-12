import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qapp/models/user_post.dart';

class SinglePost extends StatelessWidget {
  final SinglePostModel? postModel;

  const SinglePost({Key? key, this.postModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(0, 3),
            )
          ],
        ),
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '${postModel?.content}',
                style: GoogleFonts.workSans(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
