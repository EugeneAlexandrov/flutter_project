import 'package:flutter/material.dart';
import 'package:fooderlich/components/friend_post_tile.dart';
import 'package:fooderlich/models/models.dart';

class FriendPostListView extends StatelessWidget {
  const FriendPostListView({Key? key, required this.friendPosts})
      : super(key: key);

  final List<Post> friendPosts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Social Chefs 👩‍🍳',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: 16),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final post = friendPosts[index];
              return FriendlyPostTile(post: post);
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 16);
            },
            itemCount: friendPosts.length,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
