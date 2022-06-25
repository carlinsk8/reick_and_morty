import 'package:rick_and_morty/features/home/presentation/pages/person_detail_page.dart';
import 'package:rick_and_morty/shared/app_router.dart';

import 'features/home/presentation/pages/home_page.dart';
import 'features/welcome/presentation/pages/welcome_page.dart';

class AppRoute {
  static init() {
    AppRouter.appRouter
      ..define(
        routePath: WelcomePage.id,
        handler:
            AppRouteHandler(handlerFunc: (arguments) => const WelcomePage()),
      )
      ..define(
        routePath: HomePage.id,
        handler: AppRouteHandler(handlerFunc: (arguments) => const HomePage()),
      )
      ..define(
        routePath: PersonDetailPage.id,
        handler: AppRouteHandler(handlerFunc: (arguments) {
          final params = arguments as PersonDetailPageArg;

          return PersonDetailPage(args: params);
        }),
      );
  }
}
