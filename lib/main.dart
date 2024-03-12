import 'package:animeworld/config/themes/app_theme.dart';
import 'package:animeworld/cubits/anime_title_language_cubit.dart';
import 'package:animeworld/cubits/theme_cubit.dart';
import 'package:animeworld/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeCubit(),
          ),

          BlocProvider(
              create: (context) => AnimeTitleLanguageCubit(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, state) {
            final themeMode = state;

            return MaterialApp(
              themeMode: themeMode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              debugShowCheckedModeBanner: false,
              home: const HomeScreen(),
            );
          },
        ),
    );
  }
}