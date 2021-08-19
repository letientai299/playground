import 'package:flutter/material.dart';
import 'package:fooderlich/api/mock_fooderlich_service.dart';
import 'package:fooderlich/components/friend_post_list_view.dart';
import 'package:fooderlich/components/today_recipe_list_view.dart';
import 'package:fooderlich/models/explore_data.dart';

class ExploreScreen extends StatelessWidget {
  final service = MockFooderlichService();

  ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: service.getExploreData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data as ExploreData;
        return ListView(
          scrollDirection: Axis.vertical,
          children: [
            TodayRecipeListView(recipes: data.todayRecipes),
            const SizedBox(height: 16),
            FriendPostListView(posts: data.friendPosts),
          ],
        );
      },
    );
  }
}
