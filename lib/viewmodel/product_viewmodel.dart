import 'dart:developer';

import 'package:calculator/model/productcost_entity.dart';
import 'package:calculator/repositories_services/localstorage_repository.dart';
import 'package:calculator/repositories_services/localstorage_repository_imp.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

class ProductViewmodel extends ValueNotifier<double> {
  ProductViewmodel._(super._value);
  static final instance = ProductViewmodel._(0.0);

  final LocalstorageRepository _localstorage =
      LocalstorageRepositoryImp.instance;

  double _feedstockTotal = 0.0, _profit = 0.0, _additional = 0.0, _fees = 0.0;
  final _feedstockList = <double>[0, 0, 0, 0, 0, 0];

  bool status = false;

  final history = ValueNotifier<List<ProductcostEntity>>(<ProductcostEntity>[]);

  void init() {
    if (!status) {
      updateHistory();
      status = true;
    }
  }

  void end() => status = false;

  Result<bool> updateValue() {
    try {
      double result;
      if (_profit > 0.0 && _fees > 0.0) {
        result = (((_additional + _feedstockTotal) * _fees) * _profit);
      } else if (_profit > 0.0) {
        result = ((_additional + _feedstockTotal) * _profit);
      } else {
        result = (_additional + _feedstockTotal);
      }
      value = result.roundToDouble();
      return const Success(true);
    } on Exception {
      return Failure(Exception());
    }
  }

  void persistResult() {
    final cost = ProductcostEntity(
        feedstock: _feedstockTotal,
        profit: _profit,
        additional: _additional,
        fees: _fees,
        feedstockList: _feedstockList);
    _localstorage.persist('product', cost.toJson()).onSuccess((success) {
      updateHistory();
    }).onFailure((failure) => log(failure.toString()));
  }

  void updateFees(double fees) {
    _fees = (fees / 100) + 1;
    updateValue().onFailure((failure) => log(failure.toString()));
  }

  void updateProfit(double profit) {
    _profit = (profit / 100) + 1;
    updateValue().onFailure((failure) => log(failure.toString()));
  }

  void updateAdditional(double additional) {
    _additional = additional;
    updateValue().onFailure((failure) => log(failure.toString()));
  }

  void updateFeedStockTotal() {
    value = 0.0;
    _feedstockTotal = 0.0;
    for (var feed in _feedstockList) {
      _feedstockTotal += feed;
    }
    updateValue().onFailure((failure) => log(failure.toString()));
  }

  void addFeedStock(double cost, double amount, int index) {
    final total = cost * amount;
    _feedstockList[index] != total ? _feedstockList[index] = total : null;
    updateFeedStockTotal();
  }

  void removeFeedstock(int index) {
    _feedstockList[index] = 0.0;
    updateFeedStockTotal();
  }

  void updateHistory() {
    _localstorage.getCollection('product').onSuccess((success) {
      for (var element in success) {
        history.value.add(ProductcostEntity.fromJson(element));
      }
    }).onFailure((failure) => log(failure.toString()));
  }

  void clearHistory() {
    _localstorage
        .clearBox('product')
        .onSuccess((success) => history.value = <ProductcostEntity>[])
        .onFailure((failure) => log(failure.toString()));
  }
}
