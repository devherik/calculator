import 'package:flutter/material.dart';

class ProductController extends ValueNotifier<double> {
  ProductController._(super._value);
  static final instance = ProductController._(0.0);

  double _feedstockTotal = 0.0, _profit = 0.0, _additional = 0.0, _fees = 0.0;
  final _feedstockList = <double>[0, 0, 0, 0, 0, 0];

  double toNumeric(String char) {
    if (double.tryParse(char) != null) {
      return double.parse(char);
    } else {
      return 0;
    }
  }

  updateValue() {
    String result;
    if (_profit > 0.0 && _fees > 0.0) {
      result = (((_additional + _feedstockTotal) * _fees) * _profit)
          .toStringAsExponential(2);
    } else if (_profit > 0.0) {
      result =
          ((_additional + _feedstockTotal) * _profit).toStringAsExponential(2);
    } else {
      result = (_additional + _feedstockTotal).toStringAsExponential(2);
    }
    value = toNumeric(result);
  }

  updateFees(double fees) {
    _fees = (fees / 100) + 1;
    updateValue();
  }

  updateProfit(double profit) {
    _profit = (profit / 100) + 1;
    updateValue();
  }

  updateAdditional(double additional) {
    _additional = additional;
    updateValue();
  }

  updateFeedstockTotal() {
    value = 0.0;
    _feedstockTotal = 0.0;
    for (var v in _feedstockList) {
      _feedstockTotal += v;
    }
    updateValue();
  }

  addFeedstock(double cost, double amount, int index) {
    final newValue = cost * amount;
    if (_feedstockList[index] != newValue) {
      _feedstockList[index] = newValue;
      updateFeedstockTotal();
    }
  }

  removeFeedstock(int index) {
    _feedstockList[index] = 0.0;
    updateFeedstockTotal();
  }
}
