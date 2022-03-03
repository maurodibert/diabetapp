// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_nutrients.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalNutrients _$TotalNutrientsFromJson(Map<String, dynamic> json) =>
    TotalNutrients(
      nutrient: Nutrient.fromJson(json['SUGAR'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TotalNutrientsToJson(TotalNutrients instance) =>
    <String, dynamic>{
      'SUGAR': instance.nutrient.toJson(),
    };
