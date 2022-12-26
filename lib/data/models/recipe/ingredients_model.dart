import 'package:equatable/equatable.dart';
import 'package:spoonacular/data/models/recipe/nutrients_model.dart';
import 'package:spoonacular/domain/entities/recipe/ingredients.dart';

class IngredientsModel extends Equatable {
  final int? id;
  final String? name;
  final double? amount;
  final String? unit;
  final List<NutrientsModel>? nutrients;
  final String? image;
  
  const IngredientsModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.unit,
    required this.nutrients,
    required this.image,
  });

  factory IngredientsModel.fromJson(Map<String, dynamic> json) {
    return IngredientsModel(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      unit: json['unit'],
      nutrients: json['nutrients'] != null
          ? (json['nutrients'] as List)
              .map((e) => NutrientsModel.fromJson(e))
              .toList()
          : null,
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'amount': amount,
        'unit': unit,
        'nutrients': nutrients?.map((e) => e.toJson()).toList(),
        'image': image,
      };

  Ingredients toEntity() {
    return Ingredients(
      id: id,
      name: name,
      amount: amount,
      unit: unit,
      nutrients: nutrients?.map((e) => e.toEntity()).toList(),
      image: image,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        amount,
        unit,
        nutrients,
        image,
      ];
}
