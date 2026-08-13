// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hubx_flutter_case/app/router/app_router.dart' as _i399;
import 'package:hubx_flutter_case/app/router/onboarding_guard.dart' as _i976;
import 'package:hubx_flutter_case/core/network/network_module.dart' as _i297;
import 'package:hubx_flutter_case/core/storage/key_value_store.dart' as _i78;
import 'package:hubx_flutter_case/core/storage/storage_module.dart' as _i721;
import 'package:hubx_flutter_case/features/home/data/datasource/home_remote_data_source.dart'
    as _i672;
import 'package:hubx_flutter_case/features/home/data/repository/home_repository_impl.dart'
    as _i452;
import 'package:hubx_flutter_case/features/home/domain/repository/home_repository.dart'
    as _i227;
import 'package:hubx_flutter_case/features/home/domain/usecase/get_categories.dart'
    as _i937;
import 'package:hubx_flutter_case/features/home/domain/usecase/get_questions.dart'
    as _i651;
import 'package:hubx_flutter_case/features/home/presentation/bloc/home_bloc.dart'
    as _i910;
import 'package:hubx_flutter_case/features/onboarding/data/datasource/onboarding_local_data_source.dart'
    as _i994;
import 'package:hubx_flutter_case/features/onboarding/data/repository/onboarding_repository_impl.dart'
    as _i486;
import 'package:hubx_flutter_case/features/onboarding/domain/repository/onboarding_repository.dart'
    as _i1063;
import 'package:hubx_flutter_case/features/onboarding/domain/usecase/complete_onboarding.dart'
    as _i55;
import 'package:hubx_flutter_case/features/onboarding/domain/usecase/get_onboarding_status.dart'
    as _i414;
import 'package:hubx_flutter_case/features/onboarding/domain/usecase/get_subscription_plans.dart'
    as _i141;
import 'package:hubx_flutter_case/features/onboarding/presentation/intro/bloc/intro_bloc.dart'
    as _i377;
import 'package:hubx_flutter_case/features/onboarding/presentation/paywall/bloc/paywall_bloc.dart'
    as _i625;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    final storageModule = _$StorageModule();
    gh.factory<_i377.IntroBloc>(() => _i377.IntroBloc());
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio());
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => storageModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i672.HomeRemoteDataSource>(
      () => _i672.HomeRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i227.HomeRepository>(
      () => _i452.HomeRepositoryImpl(gh<_i672.HomeRemoteDataSource>()),
    );
    gh.lazySingleton<_i78.KeyValueStore>(
      () => _i78.SharedPreferencesStore(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i994.OnboardingLocalDataSource>(
      () => _i994.OnboardingLocalDataSourceImpl(gh<_i78.KeyValueStore>()),
    );
    gh.lazySingleton<_i1063.OnboardingRepository>(
      () =>
          _i486.OnboardingRepositoryImpl(gh<_i994.OnboardingLocalDataSource>()),
    );
    gh.factory<_i937.GetCategories>(
      () => _i937.GetCategories(gh<_i227.HomeRepository>()),
    );
    gh.factory<_i651.GetQuestions>(
      () => _i651.GetQuestions(gh<_i227.HomeRepository>()),
    );
    gh.factory<_i55.CompleteOnboarding>(
      () => _i55.CompleteOnboarding(gh<_i1063.OnboardingRepository>()),
    );
    gh.factory<_i414.GetOnboardingStatus>(
      () => _i414.GetOnboardingStatus(gh<_i1063.OnboardingRepository>()),
    );
    gh.factory<_i141.GetSubscriptionPlans>(
      () => _i141.GetSubscriptionPlans(gh<_i1063.OnboardingRepository>()),
    );
    gh.factory<_i910.HomeBloc>(
      () => _i910.HomeBloc(gh<_i651.GetQuestions>(), gh<_i937.GetCategories>()),
    );
    gh.factory<_i625.PaywallBloc>(
      () => _i625.PaywallBloc(
        gh<_i141.GetSubscriptionPlans>(),
        gh<_i55.CompleteOnboarding>(),
      ),
    );
    gh.factory<_i976.OnboardingGuard>(
      () => _i976.OnboardingGuard(gh<_i414.GetOnboardingStatus>()),
    );
    gh.lazySingleton<_i399.AppRouter>(
      () => _i399.AppRouter(gh<_i976.OnboardingGuard>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i297.NetworkModule {}

class _$StorageModule extends _i721.StorageModule {}
