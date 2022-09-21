import 'package:cpf_generator/src/cpf_manager/usecases/cpf_manager_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  CpfManager cpfManager = CpfManager();

  group('Tests of cpfValidator function', () {
    test('shoud return false if is empty', () {
      var isValid = cpfManager.cpfValidator('');
      expect(isValid, false);
    });

    test('should return false if the cpf.length < 11', () {
      var isValid = cpfManager.cpfValidator('1234567890'); //cpf.length = 10
      expect(isValid, false);
    });
    test('should return false if the cpf.length > 11', () {
      var isValid = cpfManager.cpfValidator('123456789012'); //cpf.length = 12
      expect(isValid, false);
    });

    test('should return true when the cpf is valid(11144477735)', () {
      var isValid = cpfManager.cpfValidator('11144477735');
      expect(isValid, true);
    });

    test('should return false when the cpf is invalid(57435863010)', () {
      var isValid = cpfManager.cpfValidator('57435863010');
      expect(isValid, false);
    });
  });

  group('Tests of cpfGenerator function', () {
    test('Should return a valid cpf', (() {
      var cpf = cpfManager.cpfGenerator();
      var isValid = cpfManager.cpfValidator(cpf);
      expect(isValid, true);
    }));
  });
}
