import 'package:cpf_generator/src/cpf_manager/services/cpf_manager_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ICpfManager cpfManager = CpfManager();
  test('shoud return false if is empty', () {
    var isValid = cpfManager.cpfValidator('');

    expect(isValid, false);
  });
}
