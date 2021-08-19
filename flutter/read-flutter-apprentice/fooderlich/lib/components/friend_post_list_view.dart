import 'package:flutter/material.dart';
import 'package:fooderlich/components/friend_post_tile.dart';
import 'package:fooderlich/models/models.dart';

class FriendPostListView extends StatelessWidget {
  final List<Post> posts;

  const FriendPostListView({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Social Chefs',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: 16),
          ListView.separated(
            primary: false,

            // if this was false (default) we got unbounded height error due to
            // nested list view
            shrinkWrap: true,

            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: posts.length,
            itemBuilder: (context, index) => FriendPostTile(post: posts[index]),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
