import 'package:calculator/viewmodel/expression_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key, required this.expressionViewmodel});
  final ExpressionViewmodel expressionViewmodel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Histórico',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [eraseButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Flexible(
          child: ValueListenableBuilder(
              valueListenable: expressionViewmodel.history,
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      historyValue(value[index].toString(), context),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Divider(
                          thickness: 0.2,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget historyValue(String value, BuildContext context) => GestureDetector(
        onTap: () async => await Clipboard.setData(ClipboardData(text: value)),
        child: Text(
          value,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      );

  Widget eraseButton() => Builder(
        builder: (context) => IconButton(
            onPressed: () => expressionViewmodel.clearHistory(),
            icon: const Icon(Iconsax.eraser)),
      );
}
