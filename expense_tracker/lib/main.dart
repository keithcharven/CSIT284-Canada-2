import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expense_tracker/widgets/expenses.dart';

final kColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color.fromARGB(255, 30, 58, 138),
  primary: const Color.fromARGB(255, 29, 78, 216),
  surface: const Color.fromARGB(255, 248, 250, 252),
);

final kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 37, 99, 235),
  primary: const Color.fromARGB(255, 59, 130, 246),
  surface: const Color.fromARGB(255, 10, 14, 23),
  background: const Color.fromARGB(255, 5, 8, 15),
);

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({super.key});

  @override
  State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = _themeMode == ThemeMode.dark;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        scaffoldBackgroundColor: const Color.fromARGB(255, 8, 12, 20),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: const Color.fromARGB(255, 15, 23, 42),
          foregroundColor: const Color.fromARGB(255, 224, 231, 255),
          centerTitle: false,
        ),
        cardTheme: const CardThemeData().copyWith(
          color: const Color.fromARGB(255, 17, 24, 39),
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 37, 99, 235),
            foregroundColor: Colors.white,
          ),
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 241, 245, 249),
            fontSize: 16,
          ),
          bodyMedium: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 226, 232, 240),
          ),
          bodySmall: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 148, 163, 184),
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        scaffoldBackgroundColor: const Color.fromARGB(255, 241, 245, 249),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: const Color.fromARGB(255, 30, 58, 138),
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
        cardTheme: const CardThemeData().copyWith(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 29, 78, 216),
            foregroundColor: Colors.white,
          ),
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 15, 23, 42),
            fontSize: 16,
          ),
          bodyMedium: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 30, 41, 59),
          ),
          bodySmall: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 100, 116, 139),
          ),
        ),
      ),
      home: Expenses(
        onToggleTheme: _toggleTheme,
        isDarkMode: isDark,
      ),
    );
  }
}