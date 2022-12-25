import 'package:equatable/equatable.dart';
import 'package:spoonacular/domain/entities/recipe/flavonoids.dart';

class FlavonoidsModel extends Equatable {
  final String? name;
  final double? amount;
  final String? unit;

  const FlavonoidsModel({
    required this.name,
    required this.amount,
    required this.unit,
  });

  factory FlavonoidsModel.fromJson(Map<String, dynamic> json) {
    return FlavonoidsModel(
      name: json['name'],
      amount: json['amount'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'amount': amount,
        'unit': unit,
      };

  Flavonoids toEntity() {
    return Flavonoids(
      name: name,
      amount: amount,
      unit: unit,
    );
  }

  @override
  List<Object?> get props => [
        name,
        amount,
        unit,
      ];
}
