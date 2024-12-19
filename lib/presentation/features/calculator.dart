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
  late ExpressionController _expressionController;
  late AnimationController _animationController;

  late Animation<double> pressController;

  @override
  void initState() {
    super.initState();
    _expressionController = ExpressionController.instance;

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..stop();
    pressController = CurvedAnimation(
        parent: _animationController, curve: Curves.bounceInOut);

    _expressionController.result.addListener(() => setState(() {}));
    _expressionController.addListener(() => setState(() {
          _expressionController.updatePartialResult();
        }));
  }

  @override
  Widget build(BuildContext context) {
    final gridLayout = <Widget>[
      clearButton(),
      symbolButton('('),
      symbolButton(')'),
      symbolButton('÷'),
      numberButton(7),
      numberButton(8),
      numberButton(9),
      symbolButton('x'),
      numberButton(4),
      numberButton(5),
      numberButton(6),
      symbolButton('-'),
      numberButton(1),
      numberButton(2),
      numberButton(3),
      symbolButton('+'),
      numberButton(0),
      symbolButton('.'),
      const SizedBox(),
      symbolButton('='),
    ];
    return Column(
      children: <Widget>[
        Expanded(flex: 2, child: Container(child: resultFormField())),
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.only(top: 32, left: 8, right: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            ),
            child: Center(
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: gridLayout,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget resultFormField() {
    return Container(
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //TODO: add transitions animations
          Text(_expressionController.value,
              style: Theme.of(context).textTheme.titleSmall),
          ValueListenableBuilder(
            valueListenable: _expressionController.result,
            builder: (context, value, child) =>
                Text(value, style: Theme.of(context).textTheme.titleMedium),
          ),
        ],
      ),
    );
  }

  Widget numberButton(int number) {
    return Builder(
      builder: (context) {
        return MaterialButton(
            shape: const CircleBorder(eccentricity: 0),
            color: Theme.of(context).colorScheme.primary,
            elevation: 0,
            child: AnimatedSize(
                duration: const Duration(microseconds: 200),
                curve: Curves.bounceInOut,
                child: Text(
                  number.toString(),
                  style: const TextStyle(color: Colors.black),
                )),
            onPressed: () => _expressionController.value += number.toString());
      },
    );
  }

  Widget symbolButton(String symbol) {
    Color color;
    switch (symbol) {
      case '.':
        color = Theme.of(context).colorScheme.primary;
      case '=':
        color = global.green;
      default:
        color = Theme.of(context).colorScheme.secondary;
    }
    return Builder(
      builder: (context) {
        return MaterialButton(
            shape: const CircleBorder(eccentricity: 0),
            color: color,
            elevation: 0.5,
            child: Text(
              symbol,
              style: const TextStyle(color: Colors.black),
            ),
            onPressed: () {
              switch (symbol) {
                case 'x':
                  symbol = '*';
                case '÷':
                  symbol = '/';
                default:
              }
              symbol == '='
                  ? _expressionController.setResult()
                  : _expressionController.value += symbol;
            });
      },
    );
  }

  Widget clearButton() {
    return Builder(
      builder: (context) {
        return MaterialButton(
            shape: const CircleBorder(eccentricity: 0),
            elevation: 0.5,
            color: global.red,
            child: const Text(
              'C',
              style: TextStyle(color: Colors.black),
            ),
            onLongPress: () => _expressionController.clearAll(),
            onPressed: () {
              _expressionController.value.isNotEmpty
                  ? _expressionController.value = _expressionController.value
                      .substring(0, _expressionController.value.length - 1)
                  : null;
            });
      },
    );
  }

  Widget emptyButton() {
    return Builder(
      builder: (context) {
        return MaterialButton(
          shape: const CircleBorder(eccentricity: 0),
          color: Theme.of(context).colorScheme.primary,
          elevation: 0,
          child: const Text(
            '',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {},
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
