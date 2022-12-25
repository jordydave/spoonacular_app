import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spoonacular/data/models/recipe/recipe_detail_model.dart';
import 'package:spoonacular/data/models/recipe/recipe_model.dart';
import 'package:spoonacular/data/models/recipe/recipe_response.dart';
import 'package:spoonacular/data/models/recipe/search_recipe_response.dart';
import 'package:spoonacular/data/models/recipe/similar_recipe_response.dart';
import 'package:spoonacular/utils/constant.dart';

import '../../../utils/exception.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> getRandomVegetarianRecipes();
  Future<List<RecipeModel>> getRandomDessertRecipes();
  Future<RecipeDetailResponse> getRecipeDetail(int id);
  Future<List<RecipeModel>> getSearchRecipe(String query);
  Future<List<RecipeModel>> getSimilarRecipe(int id);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final http.Client client;

  RecipeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RecipeModel>> getRandomVegetarianRecipes() async {
    final response = await client.get(
      Uri.parse('$baseUrl/random?number=100&$apiKey&tags=vegetarian'),
    );
    if (response.statusCode == 200) {
      return RecipeResponse.fromJson(json.decode(response.body)).recipeList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<RecipeModel>> getRandomDessertRecipes() async {
    final response = await client.get(
      Uri.parse('$baseUrl/random?number=100&$apiKey&tags=dessert'),
    );
    if (response.statusCode == 200) {
      return RecipeResponse.fromJson(json.decode(response.body)).recipeList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RecipeDetailResponse> getRecipeDetail(int id) async {
    final response = await client.get(
        Uri.parse('$baseUrl/$id/information?$apiKey&includeNutrition=true'));

    if (response.statusCode == 200) {
      return RecipeDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<RecipeModel>> getSearchRecipe(String query) async {
    final response = await client.get(Uri.parse(
        '$baseUrl/complexSearch?query=$query&$apiKey&includeNutrition=true'));

    if (response.statusCode == 200) {
      return SearchRecipeResponse.fromJson(json.decode(response.body))
          .recipeList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<RecipeModel>> getSimilarRecipe(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/$id/similar?number=100&$apiKey'));

    if (response.statusCode == 200) {
      return SimilarRecipeResponse.fromJson(json.decode(response.body))
          .recipeList;
    } else {
      throw ServerException();
    }
  }
}
