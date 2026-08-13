import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Thin wrapper over [SharedPreferences].
///
/// Features depend on this interface rather than on the plugin, which keeps
/// `shared_preferences` out of the data sources' import list and makes them
/// trivially fakeable in tests.
abstract interface class KeyValueStore {
  Future<bool?> readBool(String key);

  Future<void> writeBool(String key, {required bool value});

  Future<void> remove(String key);
}

@LazySingleton(as: KeyValueStore)
class SharedPreferencesStore implements KeyValueStore {
  const SharedPreferencesStore(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<bool?> readBool(String key) async => _prefs.getBool(key);

  @override
  Future<void> writeBool(String key, {required bool value}) =>
      _prefs.setBool(key, value);

  @override
  Future<void> remove(String key) => _prefs.remove(key);
}
