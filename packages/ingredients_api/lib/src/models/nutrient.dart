import 'package:equatable/equatable.dart';
import 'package:ingredients_api/src/models/json_map.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'nutrient.g.dart';

/// {@template nutrient}
/// Nutrient.
///
/// Contains [label], [quantity] and [unit].
///
/// [Nutrient] is immutable and can be copied using [copyWith],
/// in addition to being serialized and deserialized
/// using [toJson] and [fromJson] respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Nutrient extends Equatable {
  /// {@macro nutrient}
  const Nutrient({
    required this.label,
    required this.quantity,
    required this.unit,
  });

  /// the name of the nutrient
  final String label;

  /// the amount per requested String
  final num quantity;

  /// the unit in which is measured
  final String unit;

  /// Returns a copy of this [Nutrient] with the given values updated.
  ///
  /// {@macro recipe_detail}
  Nutrient copyWith({
    String? label,
    num? quantity,
    String? unit,
  }) {
    return Nutrient(
      label: label ?? this.label,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
    );
  }

  /// Deserializes the given [JsonMap] into a Nutrient
  static Nutrient fromJson(JsonMap json) => _$NutrientFromJson(json);

  /// Converts this [Nutrient] into a [JsonMap]
  JsonMap toJson() => _$NutrientToJson(this);

  @override
  List<Object?> get props => [label, quantity, unit];
}
