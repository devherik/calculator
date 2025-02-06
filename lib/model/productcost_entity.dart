class ProductcostEntity {
  ProductcostEntity(
      {required this.feedstock,
      required this.profit,
      required this.additional,
      required this.fees,
      required this.feedstockList});

  factory ProductcostEntity.fromJson(Map<dynamic, dynamic> json) =>
      ProductcostEntity(
          feedstock: json['feedstock'],
          profit: json['profit'],
          additional: json['sdditional'],
          fees: json['fees'],
          feedstockList: json['feedstockList']);

  double feedstock;
  double profit;
  double additional;
  double fees;
  List<double> feedstockList;
  double total = 0.0;

  void calculateTotal() {
    double result;
    if (profit > 0.0 && fees > 0.0) {
      result = (((additional + feedstock) * fees) * profit);
    } else if (profit > 0.0) {
      result = ((additional + feedstock) * profit);
    } else {
      result = (additional + feedstock);
    }
    total = result.roundToDouble();
  }

  Map<dynamic, dynamic> toJson() => {
        'feedstock': feedstock,
        'profit': profit,
        'additional': additional,
        'fees': fees,
        'feedstockList': feedstockList,
      };
}
