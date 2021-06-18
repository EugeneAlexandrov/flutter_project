import 'package:flutter/material.dart';
import 'package:fooderlich/components/circle_image.dart';
import 'package:fooderlich/models/models.dart';

class FriendlyPostTile extends StatelessWidget {
  const FriendlyPostTile({Key? key, this.post}) : super(key: key);

  final Post? post;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CircleImage(
            imageProvider: AssetImage(post?.profileImageUrl ??
                'assets/profile_pics/person_tiffany.jpeg'),
            imageRadius: 20,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post?.comment ?? 'N/A'),
              Text(
                '${post?.timestamp ?? 'N/A'} min ago',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
