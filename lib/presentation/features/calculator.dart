import 'package:calculator/presentation/controllers/calculator_controller.dart';
import 'package:flutter/material.dart';

import 'package:calculator/utils/globals.dart' as global;

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator>
    with SingleTickerProviderStateMixin {
  late CalculatorController _calculatorController;
  late AnimationController _animationController;

  late Animation<double> pressController;
  late TextEditingController resultController;

  @override
  void initState() {
    super.initState();
    _calculatorController = CalculatorController.instance;
    _calculatorController.result.addListener(() => setState(() {}));
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..stop();
    pressController = CurvedAnimation(
        parent: _animationController, curve: Curves.bounceInOut);
    resultController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            flex: 2,
            child: Container(color: global.blue, child: resultFormField())),
        Flexible(
            child: Container(
          color: global.red,
          child: Row(
            children: <Widget>[
              numberButton(1),
              numberButton(2),
              numberButton(3),
              symbolButton('+')
            ],
          ),
        ))
      ],
    );
  }

  Widget resultFormField() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SelectableText(
            _calculatorController.value,
            style: TextStyle(
              fontSize: _calculatorController.value.length < 8 ? 32 : 26,
              color: Theme.of(context).colorScheme.inversePrimary,
              letterSpacing: 2,
            ),
          ),
          global.verySmallBoxSpace,
          SelectableText(
            _calculatorController.value,
            style: TextStyle(
              fontSize: 16,
              color:
                  Theme.of(context).colorScheme.inversePrimary.withOpacity(.5),
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget numberButton(int number) {
    return Flexible(child: Builder(
      builder: (context) {
        return MaterialButton(
          shape: const CircleBorder(eccentricity: 0),
          color: Theme.of(context).colorScheme.secondary,
          child: Text(number.toString(),
              style: Theme.of(context).textTheme.labelMedium),
          onPressed: () {},
        );
      },
    ));
  }

  Widget symbolButton(String symbol) {
    return Flexible(child: Builder(
      builder: (context) {
        return MaterialButton(
          shape: const CircleBorder(eccentricity: 0),
          color: Theme.of(context).colorScheme.secondary,
          onPressed: () {},
        );
      },
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
