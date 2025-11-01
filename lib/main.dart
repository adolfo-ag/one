import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app.dart';

void main() {
  runApp(const ProviderScope(child: BilingualApp()));
}

class BilingualApp extends StatelessWidget {
  const BilingualApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5C6BC0)),
      textTheme: GoogleFonts.rubikTextTheme(),
      useMaterial3: true,
    );

    return MaterialApp(
      title: 'Lectura Bilingüe',
      theme: theme,
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateRoute: generateRoute,
      initialRoute: AppRoute.home.path,
    );
  }
}
