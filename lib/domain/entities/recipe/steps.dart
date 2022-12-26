import 'package:equatable/equatable.dart';

import 'ingredients.dart';

class Steps extends Equatable {
  final int? number;
  final String? step;
  final List<Ingredients>? ingredients;

  const Steps({
    required this.number,
    required this.step,
    required this.ingredients,
  });

  @override
  List<Object?> get props => [
        number,
        step,
        ingredients,
      ];
}