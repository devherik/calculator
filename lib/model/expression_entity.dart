class ExpressionEntity {
  ExpressionEntity({required this.sentence, required this.result});
  factory ExpressionEntity.fromJson(Map<dynamic, dynamic> json) =>
      ExpressionEntity(
          sentence: json['sentence'] as String,
          result: json['result'] as String);
  final String sentence;
  final String result;

  Map<dynamic, dynamic> toJson() => {'sentence': sentence, 'result': result};
  @override
  String toString() => '$sentence = $result';
}
