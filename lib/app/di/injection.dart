import 'package:get_it/get_it.dart';
import 'package:hubx_flutter_case/app/di/injection.config.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

/// Builds the object graph. Call once, before `runApp`.
@injectableInit
Future<GetIt> configureDependencies() => getIt.init();
