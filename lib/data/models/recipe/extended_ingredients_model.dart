import 'package:equatable/equatable.dart';
import 'package:spoonacular/domain/entities/recipe/extended_ingredients.dart';

class ExtendedIngredientsModel extends Equatable {
  final int? id;
  final String? aisle;
  final String? image;
  final String? consistency;
  final String? name;
  final String? nameClean;
  final String? original;
  final String? originalName;
  final double? amount;
  final String? unit;
  final List<dynamic>? meta;

  const ExtendedIngredientsModel({
    required this.id,
    required this.aisle,
    required this.image,
    required this.consistency,
    required this.name,
    required this.nameClean,
    required this.original,
    required this.originalName,
    required this.amount,
    required this.unit,
    required this.meta,
  });

  factory ExtendedIngredientsModel.fromJson(Map<String, dynamic> json) {
    return ExtendedIngredientsModel(
      id: json['id'],
      aisle: json['aisle'],
      image: json['image'],
      consistency: json['consistency'],
      name: json['name'],
      nameClean: json['nameClean'],
      original: json['original'],
      originalName: json['originalName'],
      amount: json['amount'],
      unit: json['unit'],
      meta: json['meta'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'aisle': aisle,
        'image': image,
        'consistency': consistency,
        'name': name,
        'nameClean': nameClean,
        'original': original,
        'originalName': originalName,
        'amount': amount,
        'unit': unit,
        'meta': meta,
      };

  ExtendedIngredients toEntity() {
    return ExtendedIngredients(
      id: id,
      aisle: aisle,
      image: image,
      consistency: consistency,
      name: name,
      nameClean: nameClean,
      original: original,
      originalName: originalName,
      amount: amount,
      unit: unit,
      meta: meta,
    );
  }

  @override
  List<Object?> get props => [
        id,
        aisle,
        image,
        consistency,
        name,
        nameClean,
        original,
        originalName,
        amount,
        unit,
        meta,
      ];
}
