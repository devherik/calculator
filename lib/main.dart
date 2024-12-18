import 'package:calculator/config/router/router.dart';
import 'package:calculator/config/theme/theme.dart';
import 'package:calculator/presentation/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final MainController mainController = MainController.instance;
  await mainController.init();
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
      themeMode: ThemeMode.light,
      darkTheme: AppTheme.dark,
      routerConfig: AppRouter().router,
    );
  }
}
