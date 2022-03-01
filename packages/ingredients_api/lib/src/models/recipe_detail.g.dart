// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeDetail _$RecipeDetailFromJson(Map<String, dynamic> json) => RecipeDetail(
      id: json['id'] as String?,
      totalNutrients: TotalNutrients.fromJson(
          json['totalNutrients'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecipeDetailToJson(RecipeDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalNutrients': instance.totalNutrients.toJson(),
    };
