import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playem/firebase_options.dart';
import 'package:playem/screen/home_music_screen.dart';
import 'package:playem/screen/register_screen.dart';
import 'package:playem/utils/favorite_provider.dart';
import 'package:playem/utils/player_provider.dart';
import 'package:playem/utils/routes.dart';
import 'package:playem/utils/service/auth_service.dart';
import 'package:playem/utils/service/notification_music_service.dart';
import 'package:playem/utils/themes/theme_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {

   await dotenv.load();
  // Firebase
  WidgetsFlutterBinding.ensureInitialized();
  final favoriteProvider = FavoriteProvider();
  // Theme
  final themeProvider = ThemeProvider();

  await themeProvider.initTheme();

  await favoriteProvider.loadFavorites();

  await NotivicationService.init();

  // Request permission for notifications
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    // Provider
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlayListProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => themeProvider),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData,
      initialRoute: '/',
      routes: appRoutes,
      home: AuthWrapper(),
    );
  }
}

// For Register
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeMusicScreen();
        } else {
          return RegisterScreen();
        }
      },
    );
  }
}
