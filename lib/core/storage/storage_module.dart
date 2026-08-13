import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provides the async-resolved [SharedPreferences] instance.
///
/// `@preResolve` makes `configureDependencies()` await it, so every consumer
/// can take it synchronously.
@module
abstract class StorageModule {
  @preResolve
  @lazySingleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
