import 'package:equatable/equatable.dart';
import 'package:spoonacular/domain/entities/recipe/recipe.dart';

class RecipeModel extends Equatable {
  const RecipeModel({
    this.vegetarian,
    this.vegan,
    this.glutenFree,
    this.dairyFree,
    this.veryHealthy,
    this.cheap,
    this.veryPopular,
    this.sustainable,
    this.title,
  });

  final bool? vegetarian;
  final bool? vegan;
  final bool? glutenFree;
  final bool? dairyFree;
  final bool? veryHealthy;
  final bool? cheap;
  final bool? veryPopular;
  final bool? sustainable;
  final String? title;

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        vegetarian: json["vegetarian"],
        vegan: json["vegan"],
        glutenFree: json["glutenFree"],
        dairyFree: json["dairyFree"],
        veryHealthy: json["veryHealthy"],
        cheap: json["cheap"],
        veryPopular: json["veryPopular"],
        sustainable: json["sustainable"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "vegetarian": vegetarian,
        "vegan": vegan,
        "glutenFree": glutenFree,
        "dairyFree": dairyFree,
        "veryHealthy": veryHealthy,
        "cheap": cheap,
        "veryPopular": veryPopular,
        "sustainable": sustainable,
        "title": title,
      };

  Recipe toEntity() {
    return Recipe(
        vegetarian: vegetarian,
        vegan: vegan,
        glutenFree: glutenFree,
        dairyFree: dairyFree,
        veryHealthy: veryHealthy,
        cheap: cheap,
        veryPopular: veryPopular,
        sustainable: sustainable,
        title: title);
  }

  @override
  List<Object?> get props => [
        vegetarian,
        vegan,
        glutenFree,
        dairyFree,
        veryHealthy,
        cheap,
        veryPopular,
        sustainable,
      ];
}