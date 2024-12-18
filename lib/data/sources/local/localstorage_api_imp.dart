import 'package:calculator/infra/port/output/localstorage_api.dart';
import 'package:localstorage/localstorage.dart';

class LocalstorageApiImp implements LocalstorageApi {
  LocalstorageApiImp._();
  static final instance = LocalstorageApiImp._();

  final List<String> expressions = [];
  int expressionsIndex = 0;

  @override
  Future<void> initApi() async {
    await initLocalStorage().whenComplete(() {
      expressionsIndex = int.parse(localStorage.getItem('INDEX') ?? '0');
      expressionsIndex > 0 ? getLocalExpressions() : null;
    });
  }

  @override
  void eraseLocalExpressions() {
    try {
      localStorage.clear();
      localStorage.setItem('INDEX', '0');
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      expressions.clear();
    }
  }

  @override
  void getLocalExpressions() {
    try {
      for (var i = 1; i <= expressionsIndex; i++) {
        expressions.add(localStorage.getItem('EXP_$expressionsIndex')!);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  void saveAnExpression(exp) {
    try {
      expressionsIndex++;
      localStorage.setItem('EXP_$expressionsIndex', exp.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
