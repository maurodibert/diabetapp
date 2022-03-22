import 'package:equatable/equatable.dart';
import 'package:ingredients_api/src/models/json_map.dart';
import 'package:ingredients_api/src/models/total_nutrients.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'recipe_detail.g.dart';

/// {@template recipe_detail}
/// A response of requested list of ingredients.
///
/// Contains [totalNutrients], and [id].
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [RecipeDetail]s are immutable and can be copied using [copyWith],
/// in addition to being serialized and deserialized
/// using [toJson] and [fromJson] respectively.
/// {@endtemplate}
@immutable
@JsonSerializable(explicitToJson: true)
class RecipeDetail extends Equatable {
  /// {@macro recipe_detail}
  RecipeDetail({
    String? id,
    this.totalNutrients,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the ingredient.
  ///
  /// Cannot be empty.
  final String id;

  /// List of nutrients
  final TotalNutrients? totalNutrients;

  /// Returns a copy of this RecipeDetail with the given values updated.
  ///
  /// {@macro recipe_detail}
  RecipeDetail copyWith({
    String? id,
    TotalNutrients? totalNutrients,
  }) {
    return RecipeDetail(
      id: id ?? this.id,
      totalNutrients: totalNutrients ?? this.totalNutrients,
    );
  }

  /// Returns an empty RecipeDetail for logic purposes
  static RecipeDetail empty() => RecipeDetail(id: '1', totalNutrients: null);

  /// Deserializes the given [JsonMap] into a RecipeDetail
  static RecipeDetail fromJson(JsonMap json) => _$RecipeDetailFromJson(json);

  /// Converts this [RecipeDetail] into a [JsonMap]
  JsonMap toJson() => _$RecipeDetailToJson(this);

  @override
  List<Object?> get props => [id, totalNutrients];
}
