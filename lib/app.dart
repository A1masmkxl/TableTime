import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Импорт твоих экранов
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/home/restaurant_list.dart';
import 'screens/booking/booking_screen.dart';
import 'package:tabletime/models/restaurant_model.dart';

class TableTimeApp extends StatelessWidget {
  const TableTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TableTime',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (_) => const SplashScreen(),
            );

          case '/login':
            return MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            );

          case '/register':
            return MaterialPageRoute(
              builder: (_) => const RegisterScreen(),
            );

          case '/home':
            return MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            );

          case '/restaurants':
            return MaterialPageRoute(
              builder: (_) => const RestaurantListScreen(),
            );

          case '/profile':
            return MaterialPageRoute(
              builder: (_) => const ProfileScreen(),
            );

          case '/booking':
            final restaurant = settings.arguments;
            if (restaurant is Restaurant) {
              return MaterialPageRoute(
                builder: (_) => BookingScreen(restaurant: restaurant),
              );
            } else {
              return MaterialPageRoute(
                builder: (_) => const SplashScreen(),
              );
            }


          default:
            return MaterialPageRoute(
              builder: (_) => const SplashScreen(),
            );
        }
      },
    );
  }
}