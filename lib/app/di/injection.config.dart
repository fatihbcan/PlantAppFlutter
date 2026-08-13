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
import 'package:hubx_flutter_case/core/network/network_module.dart' as _i297;
import 'package:hubx_flutter_case/core/storage/key_value_store.dart' as _i78;
import 'package:hubx_flutter_case/core/storage/storage_module.dart' as _i721;
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
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio());
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => storageModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i78.KeyValueStore>(
      () => _i78.SharedPreferencesStore(gh<_i460.SharedPreferences>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i297.NetworkModule {}

class _$StorageModule extends _i721.StorageModule {}
