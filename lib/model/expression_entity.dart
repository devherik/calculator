class ExpressionEntity {
  ExpressionEntity({required this.sentence, required this.result});
  factory ExpressionEntity.fromJson(Map<String, dynamic> json) =>
      ExpressionEntity(
          sentence: json['sentence'] as String,
          result: json['result'] as String);
  final String sentence;
  final String result;

  Map<String, dynamic> toJson() => {'sentence': sentence, 'result': result};
  @override
  String toString() => '$sentence = $result';
}
