import 'dart:developer';

import 'package:calculator/model/productcost_entity.dart';
import 'package:calculator/repositories_services/localstorage_repository.dart';
import 'package:calculator/repositories_services/localstorage_repository_imp.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

class ProductViewmodel extends ValueNotifier<ProductcostEntity> {
  ProductViewmodel._(super._value);
  static final instance = ProductViewmodel._(ProductcostEntity(
      feedstock: 0.0,
      profit: 0.0,
      additional: 0.0,
      fees: 0.0,
      feedstockList: <double>[]));

  final LocalstorageRepository _localstorage = LocalstorageRepositoryImp();

  bool status = false;

  final history = ValueNotifier<List<ProductcostEntity>>(<ProductcostEntity>[]);

  Future<void> init() async {
    if (!status) {
      await _localstorage.init('product');
      updateHistory();
      status = true;
    }
  }

  void end() => status = false;

  Result<bool> updateValue() {
    try {
      value.calculateTotal();
      return const Success(true);
    } on Exception {
      return Failure(Exception());
    }
  }

  void persistResult() {
    final cost = ProductcostEntity(
        feedstock: value.feedstock,
        profit: value.profit,
        additional: value.additional,
        fees: value.fees,
        feedstockList: value.feedstockList);
    _localstorage.persist(cost.toJson()).onSuccess((success) {
      updateHistory();
    }).onFailure((failure) => log(failure.toString()));
  }

  void updateFees(double fees) {
    value.fees = (fees / 100) + 1;
    updateValue().onFailure((failure) => log(failure.toString()));
  }

  void updateProfit(double profit) {
    value.profit = (profit / 100) + 1;
    updateValue().onFailure((failure) => log(failure.toString()));
  }

  void updateAdditional(double additional) {
    value.additional = additional;
    updateValue().onFailure((failure) => log(failure.toString()));
  }

  void updateFeedStockTotal() {
    value.total = 0.0;
    value.feedstock = 0.0;
    for (var feed in value.feedstockList) {
      value.feedstock += feed;
    }
    updateValue().onFailure((failure) => log(failure.toString()));
  }

  void addFeedStock(double cost, double amount, int index) {
    final total = cost * amount;
    value.feedstockList[index] != total
        ? value.feedstockList[index] = total
        : null;
    updateFeedStockTotal();
  }

  void removeFeedstock(int index) {
    value.feedstockList[index] = 0.0;
    updateFeedStockTotal();
  }

  void updateHistory() {
    _localstorage.getCollection().onSuccess((success) {
      for (var element in success) {
        history.value.add(ProductcostEntity.fromJson(element));
      }
    }).onFailure((failure) => log(failure.toString()));
  }

  void clearHistory() {
    _localstorage
        .clearBox()
        .onSuccess((success) => history.value = <ProductcostEntity>[])
        .onFailure((failure) => log(failure.toString()));
  }

  double toNumeric(String char) {
    if (double.tryParse(char) != null) {
      return double.parse(char);
    } else {
      return 0;
    }
  }
}
