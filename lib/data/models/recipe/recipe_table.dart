import 'package:equatable/equatable.dart';
import 'package:spoonacular/data/models/recipe/recipe_model.dart';
import 'package:spoonacular/domain/entities/recipe/recipe.dart';
import 'package:spoonacular/domain/entities/recipe/recipe_detail.dart';

class RecipeTable extends Equatable {
  final int? id;
  final String? title;
  final String? image;

  const RecipeTable({
    required this.id,
    required this.title,
    required this.image,
  });

  factory RecipeTable.fromEntity(RecipeDetail recipeDetail) => RecipeTable(
        id: recipeDetail.id,
        title: recipeDetail.title,
        image: recipeDetail.image,
      );

  factory RecipeTable.fromMap(Map<String, dynamic> map) => RecipeTable(
        id: map['id'],
        title: map['title'],
        image: map['image'],
      );

  factory RecipeTable.fromDTO(RecipeModel recipeModel) => RecipeTable(
        id: recipeModel.id,
        title: recipeModel.title,
        image: recipeModel.image,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
      };

  Recipe toEntity() => Recipe.favorite(
        id: id,
        title: title,
        image: image,
      );

  @override
  List<Object?> get props => [id, title, image];
}
