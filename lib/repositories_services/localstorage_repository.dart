import 'package:result_dart/result_dart.dart';

abstract class LocalstorageRepository {
  Future<Result<bool>> init(String boxName);
  Future<Result<bool>> persist(Map<dynamic, dynamic> data);
  Future<Result<List<Map<dynamic, dynamic>>>> getCollection();
  Future<Result<bool>> delete(String key);
  Future<Result<bool>> clearBox();
}
