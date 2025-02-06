import 'package:result_dart/result_dart.dart';

abstract class LocalstorageRepository {
  Future<Result<bool>> init(String boxName);
  Future<Result<bool>> persist(Map<String, dynamic> data);
  Future<Result<List<Map<String, dynamic>>>> getCollection();
  Future<Result<bool>> delete(String key);
  Future<Result<bool>> clearBox();
}
