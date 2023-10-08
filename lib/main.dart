// Flutter libraries:
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// My project libraries:
import 'package:social_media/auth/auth.dart';
import 'package:social_media/theme/theme_manager.dart';

// Shared Prefrences libraries:
import 'package:shared_preferences/shared_preferences.dart';

// Hive libraries:
import 'package:hive_flutter/adapters.dart';

// Firebase libraries:
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Allow FUTURE
  WidgetsFlutterBinding.ensureInitialized();

  // Shared Preferences Initialziation
  /*final SharedPreferences prefs =*/ await SharedPreferences.getInstance();

  // Hive Initialization
  await Hive.initFlutter();
  await Hive.openBox('Theme Mode');

  // Firebase Initailization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeManager(),
      builder: (context, child) {
        final themeManager = Provider.of<ThemeManager>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Social Media',
          themeMode: themeManager.themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: const AuthPage(),
        );
      },
    );
  }
}