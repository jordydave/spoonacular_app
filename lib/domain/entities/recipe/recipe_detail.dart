import 'package:equatable/equatable.dart';
import 'package:spoonacular/domain/entities/recipe/analyzed_instructions.dart';
import 'package:spoonacular/domain/entities/recipe/extended_ingredients.dart';
import 'package:spoonacular/domain/entities/recipe/nutrition.dart';

class RecipeDetail extends Equatable {
  final int? id;
  final String? title;
  final String? image;
  final int? servings;
  final int? readyInMinutes;
  final String? license;
  final String? sourceUrl;
  final int? aggregateLikes;
  final int? healthScore;
  final double? pricePerServing;
  final String? summary;
  final String? instructions;
  final List<ExtendedIngredients>? extendedIngredients;
  final Nutrition? nutrition;
  final List<String>? cuisines;
  final List<String>? dishTypes;
  final List<AnalyzedInstructions>? analyzedInstructions;

  const RecipeDetail({
    required this.id,
    required this.title,
    required this.image,
    required this.servings,
    required this.readyInMinutes,
    required this.license,
    required this.sourceUrl,
    required this.aggregateLikes,
    required this.healthScore,
    required this.pricePerServing,
    required this.summary,
    required this.instructions,
    required this.extendedIngredients,
    required this.nutrition,
    required this.cuisines,
    required this.dishTypes,
    required this.analyzedInstructions,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        image,
        servings,
        readyInMinutes,
        license,
        sourceUrl,
        aggregateLikes,
        healthScore,
        pricePerServing,
        summary,
        instructions,
        extendedIngredients,
        nutrition,
        cuisines,
        dishTypes,
      ];
}
