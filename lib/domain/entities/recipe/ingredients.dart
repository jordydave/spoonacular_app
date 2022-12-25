import 'package:equatable/equatable.dart';
import 'package:spoonacular/domain/entities/recipe/nutrients.dart';

class Ingredients extends Equatable {
  final int? id;
  final String? name;
  final double? amount;
  final String? unit;
  final List<Nutrients>? nutrients;

  const Ingredients({
    required this.id,
    required this.name,
    required this.amount,
    required this.unit,
    required this.nutrients,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        amount,
        unit,
        nutrients,
      ];
}
