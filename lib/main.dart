import 'package:flutter/material.dart';

import 'app.dart';
import 'di/injection_container.dart' as di;
import 'route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  AppRoute.init();

  runApp(const App());
}
