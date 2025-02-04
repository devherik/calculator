import 'package:result_dart/result_dart.dart';

abstract class LocalstorageRepository {
  Result<bool> persist(String box, Map<String, dynamic> data);
  Result<List<Map<String, dynamic>>> getCollection(String box);
  Result<bool> delete(String box, String key);
  Result<bool> clearBox(String box);
}
