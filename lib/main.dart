import 'package:flutter/material.dart';
import 'package:mirror_wall/screens/bookmark/view/bookmark_screen.dart';
import 'package:mirror_wall/screens/home/provider/home_provider.dart';
import 'package:mirror_wall/screens/home/view/home_screen.dart';
import 'package:mirror_wall/screens/search/views/search_screen.dart';
import 'package:mirror_wall/screens/setting/views/setting_screen.dart';
import 'package:mirror_wall/screens/splash/view/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeProvider()..getBrowserIndex(),
        ),
      ],
      child: Consumer<HomeProvider>(
          builder: (context, provider, child) => MaterialApp(
                theme:
                    (provider.isTheme) ? ThemeData.dark() : ThemeData.light(),
                themeMode: (provider.isTheme)
                    ? ThemeMode.dark
                    : provider.isTheme
                        ? ThemeMode.light
                        : ThemeMode.dark,
                debugShowCheckedModeBanner: false,
                routes: {
                  '/': (context) => const SplashScreen(),
                  '/home': (context) => const HomeScreen(),
                  '/search': (context) => const SearchHistoryPage(),
                  '/settings': (context) => const SettingPage(),
                  '/bookmark': (context) => const BookmarkPage(),
                },
              )),
    );
  }
}
