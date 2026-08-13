import 'package:hubx_flutter_case/core/storage/key_value_store.dart';
import 'package:hubx_flutter_case/features/onboarding/data/dto/subscription_plan_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

/// On-device state and static content for the onboarding flow.
///
/// The plan catalogue is local by design: the case exposes no billing API, so
/// the paywall is fed from here. Swapping in a real store SDK later means
/// replacing this class, not the repository or the Bloc.
abstract interface class OnboardingLocalDataSource {
  Future<bool> readCompleted();

  Future<void> writeCompleted();

  Future<List<SubscriptionPlanDto>> readPlans();
}

@LazySingleton(as: OnboardingLocalDataSource)
class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  const OnboardingLocalDataSourceImpl(this._store);

  @visibleForTesting
  static const String completedKey = 'onboarding.completed';

  final KeyValueStore _store;

  @override
  Future<bool> readCompleted() async =>
      await _store.readBool(completedKey) ?? false;

  @override
  Future<void> writeCompleted() => _store.writeBool(completedKey, value: true);

  @override
  Future<List<SubscriptionPlanDto>> readPlans() async => _catalogue;

  static const List<SubscriptionPlanDto> _catalogue = <SubscriptionPlanDto>[
    SubscriptionPlanDto(
      id: 'monthly',
      period: 'monthly',
      formattedPrice: r'$2.99',
    ),
    SubscriptionPlanDto(
      id: 'yearly',
      period: 'yearly',
      formattedPrice: r'$529.99',
      trialDays: 3,
      discountPercent: 50,
    ),
  ];
}
