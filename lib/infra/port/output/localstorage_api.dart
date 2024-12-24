abstract class LocalstorageApi<T> {
  initApi();
  getLocalExpressions();
  updateLocalExpressions();
  eraseLocalExpressions();
  saveAnExpression(T exp);
}
