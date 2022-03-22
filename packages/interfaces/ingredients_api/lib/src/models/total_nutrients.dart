import 'package:equatable/equatable.dart';
import 'package:ingredients_api/src/models/json_map.dart';
import 'package:ingredients_api/src/models/nutrient.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'total_nutrients.g.dart';

/// {@template total_nutrients}
/// Map of nutrients.
///
/// Contains a Map of [nutrient].
///
/// [TotalNutrients]s are immutable and can be copied using [copyWith],
/// in addition to being serialized and deserialized
/// using [toJson] and [fromJson] respectively.
/// {@endtemplate}
@immutable
@JsonSerializable(explicitToJson: true)
class TotalNutrients extends Equatable {
  /// {@macro total_nutrients}
  const TotalNutrients({
    required this.nutrient,
  });

  /// [Nutrient]s map
  @JsonKey(name: 'SUGAR')
  final Nutrient nutrient;

  /// Returns a copy of this [TotalNutrients] with the given values updated.
  ///
  /// {@macro recipe_detail}
  TotalNutrients copyWith({
    Nutrient? nutrient,
  }) {
    return TotalNutrients(nutrient: nutrient ?? this.nutrient);
  }

  /// Deserializes the given [JsonMap] into a RecipeDetail
  static TotalNutrients fromJson(JsonMap json) =>
      _$TotalNutrientsFromJson(json);

  /// Converts this [TotalNutrients] into a [JsonMap]
  JsonMap toJson() => _$TotalNutrientsToJson(this);

  @override
  List<Object?> get props => [nutrient];
}
