import 'package:cpf_generator/src/cpf_manager/usecases/cpf_manager_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  CpfManager cpfManager = CpfManager();
  test('shoud return false if is empty', () {
    var isValid = cpfManager.cpfValidator('');

    expect(isValid, false);
  });
}
