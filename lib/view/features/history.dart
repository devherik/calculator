import 'package:calculator/viewmodel/expression_viewmodel.dart';
import 'package:flutter/material.dart';

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
                      Text(
                        value[index].toString(),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
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
}
