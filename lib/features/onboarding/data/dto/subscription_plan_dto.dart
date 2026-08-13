import 'package:json_annotation/json_annotation.dart';

part 'subscription_plan_dto.g.dart';

/// Wire/storage shape of a plan. Never leaves `data/`.
@JsonSerializable()
class SubscriptionPlanDto {
  const SubscriptionPlanDto({
    required this.id,
    required this.period,
    required this.formattedPrice,
    this.trialDays = 0,
    this.discountPercent = 0,
  });

  factory SubscriptionPlanDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanDtoFromJson(json);

  final String id;
  final String period;
  final String formattedPrice;
  final int trialDays;
  final int discountPercent;

  Map<String, dynamic> toJson() => _$SubscriptionPlanDtoToJson(this);
}
