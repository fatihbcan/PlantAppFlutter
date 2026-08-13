// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_plan_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionPlanDto _$SubscriptionPlanDtoFromJson(Map<String, dynamic> json) =>
    SubscriptionPlanDto(
      id: json['id'] as String,
      period: json['period'] as String,
      formattedPrice: json['formattedPrice'] as String,
      trialDays: (json['trialDays'] as num?)?.toInt() ?? 0,
      discountPercent: (json['discountPercent'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SubscriptionPlanDtoToJson(
  SubscriptionPlanDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'period': instance.period,
  'formattedPrice': instance.formattedPrice,
  'trialDays': instance.trialDays,
  'discountPercent': instance.discountPercent,
};
