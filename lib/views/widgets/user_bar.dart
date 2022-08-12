import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qapp/controllers/resources.dart';

class UserBar extends StatelessWidget {
  const UserBar({
    Key? key,
    required ResSourcesController resourcesController,
  })  : _resourcesController = resourcesController,
        super(key: key);

  final ResSourcesController _resourcesController;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              '${_resourcesController.user.value.username}',
              style: GoogleFonts.workSans(
                fontSize: 20,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ],
    );
  }
}
