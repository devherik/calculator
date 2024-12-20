import 'dart:developer';

import 'package:calculator/presentation/features/calculator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    log(MediaQuery.of(context).size.toString());
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black87,
        padding: const EdgeInsets.all(8),
        child: const SafeArea(
          child: Calculator(),
        ),
      ),
    );
  }
}
