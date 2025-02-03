import 'package:calculator/data/sources/local/localstorage_api_imp.dart';
import 'package:calculator/infra/port/output/localstorage_api.dart';

class MainController {
  MainController._();
  static final instance = MainController._();

  late LocalstorageApi localstorage;

  Future<void> init() async {
    localstorage = LocalstorageApiImp.instance;
    await localstorage.initApi();
  }
}
