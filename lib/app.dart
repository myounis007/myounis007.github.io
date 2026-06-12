import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/portfolio/screens/loading_screen.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'Muhammad Younis - Senior Flutter Developer',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: buildAppTheme(Brightness.light),
          darkTheme: buildAppTheme(Brightness.dark),
          home: const LoadingScreen(),
        );
      },
    );
  }
}
