import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'utils/constants.dart';
import 'screens/splash_screen.dart';
import 'screens/main_container.dart';
import 'screens/offline_dashboard.dart';
import 'services/offline_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Lock orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OfflineService()),
      ],
      child: const HLEduroomApp(),
    ),
  );
}

class HLEduroomApp extends StatelessWidget {
  const HLEduroomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.accent,
          background: AppColors.background,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.text,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.primary),
          titleTextStyle: TextStyle(
            color: AppColors.text,
            fontSize: 14, // STRICT: 14sp
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(fontSize: 11), // STRICT: 11sp
          unselectedLabelStyle: TextStyle(fontSize: 11),
        ),
        useMaterial3: true,
      ),
      builder: (context, child) {
        // STRICT: Disable system font scaling
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const MainContainer(),
        '/offline': (context) => const OfflineDashboard(),
      },
    );
  }
}
