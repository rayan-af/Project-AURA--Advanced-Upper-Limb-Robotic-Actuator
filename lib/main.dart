import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/localization/app_translations.dart';
import 'core/localization/locale_provider.dart';
import 'features/calibration/presentation/views/dashboard_view.dart';

void main() {
  // Always wrap your root widget in a ProviderScope to initialize Riverpod
  runApp(
    const ProviderScope(
      child: RealSkinnApp(),
    ),
  );
}

class RealSkinnApp extends ConsumerWidget {
  const RealSkinnApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      title: 'RealSkinn Controller',
      debugShowCheckedModeBanner: false,
      
      // 1. Accessibility & High Contrast Theme Design
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212), // Pure dark accessibility background
        primaryColor: const Color(0xFF00BFA5),            // High-contrast Teal accent
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00BFA5),
          secondary: Color(0xFF818CF8),
          error: Color(0xFFEF4444),
          surface: Color(0xFF1F1F1F),
        ),
        fontFamily: 'Cairo',                             // Standard readable Arabic typeface
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.grey, fontSize: 14),
          headlineSmall: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
          titleLarge: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),

      // 2. Localized Setup
      locale: locale, 
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('ar', 'QA'), // Arabic
        Locale('fr', 'FR'), // French
        Locale('de', 'DE'), // German
        Locale('zh', 'CN'), // Chinese
        Locale('ja', 'JP'), // Japanese
      ],
      localizationsDelegates: const [
        AppTranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // 3. Entry Screen
      home: const DashboardView(),
    );
  }
}
