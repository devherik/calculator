abstract class LocalstorageApi<T> {
  initApi();
  getLocalExpressions();
  eraseLocalExpressions();
  saveAnExpression(T exp);
}
