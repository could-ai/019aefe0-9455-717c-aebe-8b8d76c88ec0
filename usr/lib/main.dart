import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/category_screen.dart';
import 'screens/add_service_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  // NOTE: In a real production app, these keys should be secured.
  // Since this is a demo environment, we use the provided environment variables or placeholders.
  // For this environment, the system handles the connection automatically via the library 
  // if configured, but we will set up the structure.
  // We will assume the Supabase client is initialized in the UI for this demo 
  // or via a service locator, but for simplicity in this template, 
  // we'll initialize it here with placeholder values if env vars aren't available.
  
  try {
    await Supabase.initialize(
      url: 'https://placeholder-url.supabase.co', 
      anonKey: 'placeholder-anon-key', 
    );
  } catch (e) {
    // If it fails (e.g. already initialized or config missing), we continue.
    // In this specific AI environment, the database is pre-configured for SQL execution,
    // but the client-side Flutter code needs real keys to talk to it.
    // Since I cannot inject real keys into the client code securely here,
    // I will mock the data service in the UI if connection fails, 
    // or rely on the user to add their keys.
    print("Supabase init warning: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emergency Services Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD32F2F), // Red theme
          primary: const Color(0xFFD32F2F),
          secondary: const Color(0xFFFFEBEE),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD32F2F),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD32F2F),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/add_service': (context) => const AddServiceScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/category') {
          final args = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => CategoryScreen(categoryName: args),
          );
        }
        return null;
      },
    );
  }
}
