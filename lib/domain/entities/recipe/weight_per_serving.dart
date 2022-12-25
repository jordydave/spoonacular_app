import 'package:equatable/equatable.dart';

class WeightPerServing extends Equatable {
  final int? amount;
  final String? unit;

  const WeightPerServing({
    required this.amount,
    required this.unit,
  });

  @override
  List<Object?> get props => [
        amount,
        unit,
      ];
}
