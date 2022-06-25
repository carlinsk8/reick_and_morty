import 'package:get_it/get_it.dart';

import '../core/api/public_http_client.dart';

initCore(GetIt sl) {
  sl.registerLazySingleton(
    () => PublicHttpClient(),
  );
}
