class ProductcostEntity {
  ProductcostEntity(
      {required this.feedstock,
      required this.profit,
      required this.additional,
      required this.fees,
      required this.feedstockList});

  factory ProductcostEntity.fromJson(Map<String, dynamic> json) =>
      ProductcostEntity(
          feedstock: json['feedstock'],
          profit: json['profit'],
          additional: json['sdditional'],
          fees: json['fees'],
          feedstockList: json['feedstockList']);

  final double feedstock;
  final double profit;
  final double additional;
  final double fees;
  final List<double> feedstockList;

  Map<String, dynamic> toJson() => {
        'feedstock': feedstock,
        'profit': profit,
        'additional': additional,
        'fees': fees,
        'feedstockList': feedstockList,
      };
}
