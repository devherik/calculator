import 'package:calculator/config/router/router.dart';
import 'package:calculator/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Calculadora';
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: AppTheme.light,
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.dark,
      routerConfig: AppRouter().router,
    );
  }
}
