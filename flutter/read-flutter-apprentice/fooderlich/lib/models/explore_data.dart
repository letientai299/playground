import 'package:fooderlich/models/explore_recipe.dart';
import 'package:fooderlich/models/post.dart';

class ExploreData {
  final List<ExploreRecipe> todayRecipes;
  final List<Post> friendPosts;

  ExploreData(this.todayRecipes, this.friendPosts);
}
