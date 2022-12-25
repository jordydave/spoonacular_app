import 'package:equatable/equatable.dart';
import 'package:spoonacular/domain/entities/recipe/recipe.dart';

class RecipeModel extends Equatable {
  const RecipeModel({
    this.title,
    this.image,
    this.id,
  });

  final String? title;
  final String? image;
  final int? id;

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        title: json["title"],
        image: json["image"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "id": id,
      };

  Recipe toEntity() {
    return Recipe(
      title: title,
      image: image,
      id: id,
    );
  }

  @override
  List<Object?> get props => [
        title,
        image,
        id,
      ];
}
