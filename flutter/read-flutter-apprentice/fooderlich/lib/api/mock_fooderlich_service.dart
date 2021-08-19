import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fooderlich/models/models.dart';

class MockFooderlichService {
  Future<ExploreData> getExploreData() async {
    final recipes = await _getTodayRecipes();
    final posts = await _getFriendFeed();
    return ExploreData(recipes, posts);
  }

  Future<List<SimpleRecipe>> getRecipes() async {
    final json = await _loadJson('assets/sample_data/sample_recipes.json');
    return json['recipes']?.map(SimpleRecipe.parseJson).toList();
  }

  Future<List<ExploreRecipe>> _getTodayRecipes() async {
    final json = await _loadJson(
      'assets/sample_data/sample_explore_recipes.json',
    );
    return json['recipes']?.map(ExploreRecipe.parseJson).toList();
  }

  Future<List<Post>> _getFriendFeed() async {
    final json = await _loadJson(
      'assets/sample_data/sample_friends_feed.json',
    );
    return json['feed']?.map(Post.parseJson).toList();
  }

  Future<Map<String, dynamic>> _loadJson(String path) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final dataString = await _loadAsset(path);
    return jsonDecode(dataString);
  }

  _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }
}
