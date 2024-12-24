import 'dart:developer';

import 'package:calculator/data/sources/local/localstorage_api_imp.dart';
import 'package:calculator/infra/port/output/localstorage_api.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalstorageApi localstorageApi = LocalstorageApiImp.instance;
    List<String> list = [];
    try {
      list = localstorageApi.getLocalExpressions();
    } on Exception catch (e) {
      log(e.toString());
    }
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
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) => Column(
              children: [
                Text(
                  list[index],
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
          ),
        ),
      ),
    );
  }
}
