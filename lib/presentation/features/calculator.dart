import 'package:calculator/presentation/controllers/expression_controller.dart';
import 'package:flutter/material.dart';

import 'package:calculator/utils/globals.dart' as global;

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator>
    with SingleTickerProviderStateMixin {
  late ExpressionController _calculatorController;
  late AnimationController _animationController;

  late Animation<double> pressController;
  late TextEditingController resultController;

  @override
  void initState() {
    super.initState();
    _calculatorController = ExpressionController.instance;

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..stop();
    pressController = CurvedAnimation(
        parent: _animationController, curve: Curves.bounceInOut);
    resultController = TextEditingController();

    _calculatorController.result.addListener(() => setState(() {}));
    resultController.addListener(() {
      _calculatorController.value = resultController.text;
      _calculatorController.updatePartialResult();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            flex: 2,
            child: Container(color: global.blue, child: resultFormField())),
        Flexible(
            child: Row(
          children: <Widget>[
            numberButton(1),
            numberButton(2),
            numberButton(3),
            symbolButton('+')
          ],
        )),
        Flexible(
            child: Row(
          children: <Widget>[
            numberButton(1),
            numberButton(2),
            numberButton(3),
            symbolButton('+')
          ],
        )),
        Flexible(
            child: Row(
          children: <Widget>[
            numberButton(1),
            numberButton(2),
            numberButton(3),
            symbolButton('+')
          ],
        )),
        Flexible(
            child: Row(
          children: <Widget>[
            numberButton(1),
            numberButton(2),
            numberButton(3),
            symbolButton('+')
          ],
        ))
      ],
    );
  }

  Widget resultFormField() {
    return Container(
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: resultController,
        keyboardType:
            const TextInputType.numberWithOptions(decimal: true, signed: true),
        enabled: true,
        maxLength: 24,
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          helper: ValueListenableBuilder(
            valueListenable: _calculatorController.result,
            builder: (context, value, child) {
              return Text(value);
            },
          ),
          border: UnderlineInputBorder(),
          disabledBorder: UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(),
          focusedBorder: UnderlineInputBorder(),
          errorBorder: UnderlineInputBorder(),
        ),
      ),
    );
  }

  Widget numberButton(int number) {
    return Flexible(child: Builder(
      builder: (context) {
        return MaterialButton(
          shape: const CircleBorder(eccentricity: 0),
          color: Theme.of(context).colorScheme.secondary,
          child: AnimatedSize(
            duration: const Duration(microseconds: 200),
            curve: Curves.bounceInOut,
            child: Text(number.toString(),
                style: Theme.of(context).textTheme.labelMedium),
          ),
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
