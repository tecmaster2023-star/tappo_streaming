import 'package:get_it/get_it.dart';
import 'package:tappo_streaming/core/network/api_client.dart';
import 'package:tappo_streaming/core/storage/secure_storage.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton(() => SecureStorage());
  sl.registerLazySingleton(() => ApiClient(sl<SecureStorage>()));
  sl.registerLazySingleton(() => AuthRepository(sl<ApiClient>(), sl<SecureStorage>()));
}
