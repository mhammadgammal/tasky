import 'base_parameter.dart';

abstract interface class ParameterUseCase<T,P extends BaseParameter> {
  Future<T> perform(P parameter);
}