import 'package:equatable/equatable.dart';

class Flavonoids extends Equatable {
  final String? name;
  final double? amount;
  final String? unit;

  const Flavonoids({
    required this.name,
    required this.amount,
    required this.unit,
  });

  @override
  List<Object?> get props => [
        name,
        amount,
        unit,
      ];
}
