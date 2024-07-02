import 'package:cryptowallet/screens/home_page.dart';
import 'package:cryptowallet/screens/start_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Wallet',
      initialRoute: 'startpage',
      routes: {
        'startpage': (context) => const StartPage(),
        'homepage': (context) => const HomePage(),
        // 'marketplace': (context) => const MarketPlace(),
        // 'profile': (context) => const ProfilePage(),
        // 'favorites': (context) => const FavoritesPage(),
        // 'details': (context) => const DetailsPage(),
      },
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
    );
  }
}
