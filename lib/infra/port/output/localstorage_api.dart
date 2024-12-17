abstract class LocalstorageApi<T> {
  void initApi();
  void getLocalExpressions();
  void eraseLocalExpressions();
  void saveAnExpression(T exp);
}
