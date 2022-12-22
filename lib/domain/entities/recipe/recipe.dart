import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  const Recipe({
    this.vegetarian,
    this.vegan,
    this.glutenFree,
    this.dairyFree,
    this.veryHealthy,
    this.cheap,
    this.veryPopular,
    this.sustainable,
    this.title,
    this.image,
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
  final String? image;

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
        title,
        image,
      ];
}
