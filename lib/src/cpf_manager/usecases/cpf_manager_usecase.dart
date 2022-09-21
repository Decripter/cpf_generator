import 'dart:math';

class CpfManager {
  //

  String cpfGenerator() {
    var validatorDigit = '';
    var cpf = '';
    for (int digit = 0; digit < 9; digit++) {
      cpf = '$cpf${Random().nextInt(9)}';
    }

    validatorDigit =
        '$validatorDigit${_getValidatorDigit(cpf: cpf, digitsForLoop: 8)}';
    validatorDigit =
        '$validatorDigit${_getValidatorDigit(cpf: '$cpf$validatorDigit', digitsForLoop: 9)}';

    return '$cpf$validatorDigit';
  }

  bool cpfValidator(String cpf) {
    //
    if (cpf.isEmpty || cpf.length != 11) {
      return false;
    }

    var validatorDigit = '';
    var validatorDigitOriginal = cpf.substring(9, 11);

    validatorDigit =
        '$validatorDigit${_getValidatorDigit(cpf: cpf, digitsForLoop: 8)}';
    validatorDigit =
        '$validatorDigit${_getValidatorDigit(cpf: cpf, digitsForLoop: 9)}';

    return (int.parse(validatorDigit) == int.parse(validatorDigitOriginal));
  }

  int _getValidatorDigit({required String cpf, required int digitsForLoop}) {
    var cpfSum = 0;
    var mult = 2;
    for (int digit = digitsForLoop; digit >= 0; digit--) {
      cpfSum = (int.parse(cpf[digit]) * mult) + cpfSum;
      mult++;
    }

    if (cpfSum % 11 < 2) {
      return 0;
    } else {
      return 11 - (cpfSum % 11);
    }
  }
}
