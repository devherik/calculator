import 'package:calculator/repositories_services/localstorage_repository.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:result_dart/result_dart.dart';

class LocalstorageRepositoryImp implements LocalstorageRepository {
  LocalstorageRepositoryImp();

  late Box box;

  @override
  Future<Result<bool>> init(String boxName) async {
    try {
      box = await Hive.openBox(boxName);
      return Success(box.isOpen);
    } on Exception {
      return Failure(Exception('Unable to open a box'));
    }
  }

  @override
  Future<Result<bool>> clearBox() async {
    try {
      box.clear();
      return const Success(true);
    } on Exception {
      return Failure(Exception('Box was not wiped'));
    }
  }

  @override
  Future<Result<bool>> delete(String key) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Map<dynamic, dynamic>>>> getCollection() async {
    try {
      final data = box.values;
      final list = <Map<dynamic, dynamic>>[];
      for (var e in data) {
        list.add(e);
      }
      return Success(list);
    } on Exception {
      return Failure(Exception('Box was not wiped'));
    }
  }

  @override
  Future<Result<bool>> persist(Map<dynamic, dynamic> data) async {
    try {
      box.add(data);
      return const Success(true);
    } on Exception {
      return Failure(Exception('Data not saved'));
    }
  }
}
