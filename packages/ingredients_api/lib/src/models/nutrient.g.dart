// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nutrient _$NutrientFromJson(Map<String, dynamic> json) => Nutrient(
      label: json['label'] as String,
      quantity: json['quantity'] as num,
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$NutrientToJson(Nutrient instance) => <String, dynamic>{
      'label': instance.label,
      'quantity': instance.quantity,
      'unit': instance.unit,
    };
