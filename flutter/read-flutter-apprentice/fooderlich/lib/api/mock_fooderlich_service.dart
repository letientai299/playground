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
    return List<SimpleRecipe>.from(
      json['recipes']?.map((e) => SimpleRecipe.fromJson(e)),
    );
  }

  Future<List<ExploreRecipe>> _getTodayRecipes() async {
    final json = await _loadJson(
      'assets/sample_data/sample_explore_recipes.json',
    );

    final data = json['recipes'].map((e) => ExploreRecipe.fromJson(e));
    return List<ExploreRecipe>.from(data);
  }

  Future<List<Post>> _getFriendFeed() async {
    final json = await _loadJson(
      'assets/sample_data/sample_friends_feed.json',
    );
    return List<Post>.from(json['feed'].map((e) => Post.fromJson(e)));
  }

  Future<Map<String, dynamic>> _loadJson(String path) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final dataString = await _loadAsset(path);
    return jsonDecode(dataString);
  }

  _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }
}
