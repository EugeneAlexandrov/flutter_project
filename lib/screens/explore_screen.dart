import 'package:flutter/material.dart';
import 'package:fooderlich/api/mock_fooderlich_service.dart';
import 'package:fooderlich/components/components.dart';
import 'package:fooderlich/components/friend_post_list_view.dart';
import 'package:fooderlich/models/models.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({Key? key}) : super(key: key);

  final mockService = MockFooderlichService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ExploreData>(
        future: mockService.getExploreData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final List<ExploreRecipe> recipes = snapshot.data!.todayRecipes;
              final List<Post> posts = snapshot.data!.friendPosts;
              return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  TodayRecipeListView(recipes: recipes),
                  const SizedBox(height: 16),
                  FriendPostListView(friendPosts: posts),
                ],
              );
            } else {
              return Center(child: Text('Error'));
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
