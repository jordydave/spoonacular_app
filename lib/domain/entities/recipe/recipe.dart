import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  const Recipe({
    this.title,
    this.image,
    this.id,
  });

  const Recipe.favorite({
    this.title,
    this.image,
    this.id,
  });

  final String? title;
  final String? image;
  final int? id;

  @override
  List<Object?> get props => [
        title,
        image,
        id,
      ];
}
