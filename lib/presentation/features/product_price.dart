import 'package:calculator/presentation/controllers/product_controller.dart';
import 'package:calculator/utils/utils_widgets.dart';
import 'package:flutter/material.dart';
import 'package:calculator/utils/globals.dart' as globals;

class ProductPricePage extends StatefulWidget {
  const ProductPricePage({super.key});

  @override
  State<ProductPricePage> createState() => _ProductPricePageState();
}

class _ProductPricePageState extends State<ProductPricePage> {
  final _additionalCostsTextController = TextEditingController();
  final _feesTextController = TextEditingController();
  final _profitTextcontroller = TextEditingController();
  final minWidht = 320.0, minHeight = 800.0;
  final _countFeedstock$ = ValueNotifier<int>(1);
  final List<Widget> _feedList = [];
  final _controller = ProductController.instance;

  @override
  void initState() {
    super.initState();
    _countFeedstock$.addListener(() => setState(() {}));
    _additionalCostsTextController.addListener(() => setState(() {
          _controller.updateAdditional(
              _controller.toNumeric(_additionalCostsTextController.text));
        }));
    _profitTextcontroller.addListener(() => setState(() {
          _controller
              .updateProfit(_controller.toNumeric(_profitTextcontroller.text));
        }));
    _feesTextController.addListener(() => setState(() {
          _controller
              .updateFees(_controller.toNumeric(_feesTextController.text));
        }));
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    if (_feedList.isEmpty) {
      _feedList.add(feedsotckFields(_countFeedstock$.value));
    }
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 1, child: resultFutureField()),
          globals.verySmallBoxSpace,
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
              ),
              padding: const EdgeInsets.only(top: 32),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Materiais utilizados',
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.help_outline_outlined,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ))
                            ],
                          ),
                          globals.verySmallBoxSpace,
                          feedstockAmountControl(),
                          globals.smallBoxSpace,
                          ListView.builder(
                            physics: const ScrollPhysics(
                                parent: NeverScrollableScrollPhysics()),
                            shrinkWrap: true,
                            itemCount: _feedList.length,
                            itemBuilder: (context, index) => _feedList[index],
                          ),
                        ],
                      ),
                      globals.verySmallBoxSpace,
                      Divider(
                        color: Theme.of(context).colorScheme.tertiary,
                        thickness: 1,
                      ),
                      globals.verySmallBoxSpace,
                      UtilsWidgets().formFieldPrefix(
                          context,
                          _additionalCostsTextController,
                          'Custos adicionais',
                          'R\$ '),
                      globals.smallBoxSpace,
                      UtilsWidgets().formFieldSufix(context,
                          _feesTextController, 'Taxas e impostos', ' %'),
                      globals.smallBoxSpace,
                      UtilsWidgets().formFieldSufix(context,
                          _profitTextcontroller, 'Lucro desejado', ' %'),
                      globals.smallBoxSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [clearButton(), shareButton()],
                      ),
                      globals.smallBoxSpace
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget resultFutureField() {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'R\$',
                style: TextStyle(
                  fontSize: 36,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  letterSpacing: 2,
                ),
              ),
              Text(
                ' ${_controller.value}',
                style: TextStyle(
                  fontSize: 36,
                  color: Theme.of(context).colorScheme.tertiary,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          globals.verySmallBoxSpace,
          SizedBox(
            width: MediaQuery.of(context).size.width * .5,
            child: Divider(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget feedstockAmountControl() {
    return Card(
      color: Theme.of(context).colorScheme.tertiary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
                onPressed: () {
                  if (_countFeedstock$.value > 1) {
                    _controller.removeFeedstock(_countFeedstock$.value - 1);
                    _countFeedstock$.value--;
                    _feedList.removeLast();
                  }
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: _countFeedstock$.value > 1
                      ? Theme.of(context).colorScheme.inversePrimary
                      : Theme.of(context).colorScheme.secondary,
                )),
            ValueListenableBuilder(
              valueListenable: _countFeedstock$,
              builder: (context, value, child) => Text(
                (value).toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            IconButton(
                onPressed: () {
                  if (_countFeedstock$.value < 5) {
                    _countFeedstock$.value++;
                    _feedList.add(feedsotckFields(_countFeedstock$.value));
                  }
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: _countFeedstock$.value < 5
                      ? Theme.of(context).colorScheme.inversePrimary
                      : Theme.of(context).colorScheme.secondary,
                )),
          ],
        ),
      ),
    );
  }

  Widget feedsotckFields(int index) {
    final key = Key(index.toString());
    final valueTextController = TextEditingController();
    final amountTextController = TextEditingController();
    amountTextController.addListener(() => setState(() {
          _controller.addFeedstock(
              _controller.toNumeric(valueTextController.text),
              _controller.toNumeric(amountTextController.text),
              index);
        }));
    return Row(
      key: key,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              controller: valueTextController,
              maxLines: 1,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge,
              showCursor: false,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  hintText: 'Valor',
                  hintStyle: Theme.of(context).textTheme.labelMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  counterStyle: Theme.of(context).textTheme.bodyMedium,
                  prefixText: 'R\$ ',
                  prefixStyle: Theme.of(context).textTheme.bodyLarge),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              controller: amountTextController,
              maxLines: 1,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge,
              showCursor: false,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  hintText: '    Quantidade',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  counterStyle: Theme.of(context).textTheme.bodyMedium),
            ),
          ),
        ),
      ],
    );
  }

  Widget clearButton() {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      splashColor: Theme.of(context).colorScheme.inversePrimary,
      onPressed: () {
        _additionalCostsTextController.clear();
        _feesTextController.clear();
        _profitTextcontroller.clear();
        do {
          _controller.removeFeedstock(_countFeedstock$.value);
          _countFeedstock$.value--;
          _feedList.removeLast();
        } while (_countFeedstock$.value != 0);
        _countFeedstock$.value = 1;
      },
      child: Text(
        'Limpar',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget shareButton() {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
      elevation: 1,
      color: Theme.of(context).colorScheme.tertiary,
      splashColor: Theme.of(context).colorScheme.inversePrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Text(
        'Compartilhar',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onPressed: () {},
    );
  }
}
