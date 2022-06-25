import 'package:get_it/get_it.dart';

import '../features/home/di/home_di.dart';
import 'core_module.dart';
import 'external_module.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core

  initCore(sl);

  //! External
  await initExternal(sl);

  //! Features

  initHomeModule(sl);
}
