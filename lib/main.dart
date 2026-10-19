import 'package:tappo_streaming/core/theme/app_theme.dart';
import 'package:tappo_streaming/features/auth/screens/login_screen.dart';
import 'package:tappo_streaming/features/auth/screens/register_screen.dart';
import 'package:tappo_streaming/features/downloads/screens/downloads_screen.dart';
import 'package:tappo_streaming/features/epg/screens/epg_screen.dart';
import 'package:tappo_streaming/features/home/screens/home_screen.dart';
import 'package:tappo_streaming/features/parental_control/screens/parental_control_screen.dart';
import 'package:tappo_streaming/features/player/screens/video_player_screen.dart';
import 'package:tappo_streaming/features/profiles/screens/profiles_screen.dart';
import 'package:tappo_streaming/features/splash/screens/splash_screen.dart';
import 'package:tappo_streaming/injection_container.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const TappoApp());
}

class TappoApp extends StatelessWidget {
  const TappoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tappo Streaming',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      routerConfig: AppRouter.router,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/video/:url', builder: (context, state) {
        final url = Uri.decodeComponent(state.pathParameters['url'] ?? '');
        return VideoPlayerScreen(streamUrl: url);
      }),
      GoRoute(path: '/epg', builder: (context, state) => const EpgScreen()),
      GoRoute(path: '/downloads', builder: (context, state) => const DownloadsScreen()),
      GoRoute(path: '/parental', builder: (context, state) => const ParentalControlScreen()),
      GoRoute(path: '/profiles', builder: (context, state) => const ProfilesScreen()),
    ],
  );
}
