import 'package:go_router/go_router.dart';
import 'package:calculator/presentation/controllers/expression_controller.dart';
import 'package:flutter/material.dart';

import 'package:calculator/utils/globals.dart' as global;
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

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

    _expressionController.addListener(() => setState(() {
          _expressionController.value.length < 18
              ? _expressionController.updatePartialResult()
              : null;
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
      removeLastButton(),
      symbolButton('='),
    ];
    return Column(
      children: <Widget>[
        Flexible(child: resultFormField()),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              iconButton(const Icon(Iconsax.timer), '/home/history'),
              iconButton(const Icon(Iconsax.coin), '/home/product')
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            ),
            child: Center(
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
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
              style: GoogleFonts.ubuntu(
                  fontSize: 24,
                  letterSpacing: 1.5,
                  color: global.primaryLightColor)),
          ValueListenableBuilder(
            valueListenable: _expressionController.result,
            builder: (context, value, child) => Text(value,
                style: GoogleFonts.ubuntu(
                    fontSize: 48,
                    letterSpacing: 1.5,
                    color: global.terciaryLightColor)),
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
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                )),
            onPressed: () => _expressionController.value.length < 18
                ? _expressionController.value += number.toString()
                : null);
      },
    );
  }

  Widget symbolButton(String symbol) {
    Color color;
    double elevation = 0.5;
    switch (symbol) {
      case '.':
        color = Theme.of(context).colorScheme.primary;
        elevation = 0;
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
            elevation: elevation,
            child: Text(
              symbol,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
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
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            onPressed: () {
              _expressionController.clearAll();
            });
      },
    );
  }

  Widget removeLastButton() {
    return Builder(
      builder: (context) {
        return MaterialButton(
            shape: const CircleBorder(eccentricity: 0),
            elevation: 0,
            color: Theme.of(context).colorScheme.primary,
            child: const Icon(Iconsax.back_square4),
            onPressed: () {
              _expressionController.value.isNotEmpty
                  ? _expressionController.value = _expressionController.value
                      .substring(0, _expressionController.value.length - 1)
                  : null;
            });
      },
    );
  }

  Widget iconButton(Icon icon, String route) {
    return Builder(
      builder: (context) =>
          IconButton(onPressed: () => context.go(route), icon: icon),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
