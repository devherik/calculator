import 'package:calculator/repositories_services/localstorage_repository.dart';
import 'package:result_dart/src/types.dart';

class LocalstorageRepositoryImp implements LocalstorageRepository {
  const LocalstorageRepositoryImp._();
  static const instance = LocalstorageRepositoryImp._();

  @override
  Result<bool> clearBox(String box) {
    // TODO: implement clearBox
    throw UnimplementedError();
  }

  @override
  Result<bool> delete(String box, String key) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Result<List<Map<String, dynamic>>> getCollection(String box) {
    // TODO: implement getCollection
    throw UnimplementedError();
  }

  @override
  Result<bool> persist(String box, Map<String, dynamic> data) {
    // TODO: implement persist
    throw UnimplementedError();
  }
}
