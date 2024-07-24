abstract interface class NoParameterUseCase<T>{
  Future<T> perform();
}