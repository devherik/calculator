import 'dart:developer';

import 'package:calculator/presentation/features/calculator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    log(MediaQuery.of(context).size.toString());
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Calculator(),
      ),
    );
  }
}
