import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/di/injection_container.dart';
import 'package:rick_and_morty/features/welcome/presentation/pages/welcome_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/home/presentation/bloc/character/character_bloc.dart';
import 'features/home/presentation/bloc/episodies/episodies_bloc.dart';
import 'shared/app_router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<CharacterBloc>()),
        BlocProvider(create: (_) => sl<EpisodiesBloc>()),
      ],
      child: MaterialApp(
        title: 'Rick And Morty',
        home: const WelcomePage(),
        onGenerateRoute: (settings) => AppRouter.appRouter.matchRoute(
          settings.name!,
          routeSettings: settings,
        ),
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(textTheme).copyWith(
            bodyText2: GoogleFonts.montserrat(textStyle: textTheme.bodyText2),
          ),
        ),
      ),
    );
  }
}
