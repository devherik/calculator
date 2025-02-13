import 'package:calculator/config/router/router.dart';
import 'package:calculator/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final dir = await getApplicationDocumentsDirectory();
  Hive.initFlutter(dir.path);
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
