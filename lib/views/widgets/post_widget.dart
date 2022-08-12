import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qapp/controllers/resources.dart';
import 'package:qapp/models/post_model.dart';

class PostWidget extends StatelessWidget {
  final PostModel? postModel;

  const PostWidget({
    Key? key,
    this.postModel,
  }) : super(key: key);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://picsum.photos/200',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${postModel?.user?.username}',
                      style: GoogleFonts.workSans(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${postModel?.createdAt}',
                  style: GoogleFonts.workSans(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '${postModel?.content}',
                style: GoogleFonts.workSans(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Icon(Icons.favorite_border),
                  const SizedBox(width: 8),
                  Text(
                    '0',
                    style: GoogleFonts.workSans(fontSize: 12),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.chat_bubble_outline),
                  const SizedBox(width: 8),
                  Text(
                    '0',
                    style: GoogleFonts.workSans(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
