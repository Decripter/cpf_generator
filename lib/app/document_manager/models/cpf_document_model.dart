import 'dart:math';

import 'document_model.dart';

class CPFDocumentModel extends DocumentModel {
  String value;
  CPFDocumentModel(this.value);

  @override
  String documentGenerator() {
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

  @override
  String removeMask(String document) {
    String documentClear = document.replaceAll(RegExp(r'\D'), '');
    return documentClear;
  }

  @override
  String generateMaskedDocument() {
    String document = documentGenerator();
    String documentMasked = applyMask(document);
    return documentMasked;
  }

  @override
  String applyMask(String document) {
    String documentMasked = '';
    for (int digit = 0; digit < document.length; digit++) {
      if (digit == 3 || digit == 6) {
        documentMasked = "$documentMasked.${document[digit]}";
      } else if (digit == 9) {
        documentMasked = "$documentMasked-${document[digit]}";
      } else {
        documentMasked = "$documentMasked${document[digit]}";
      }
    }
    return documentMasked;
  }

  @override
  bool validateDocument(String document) {
    document = removeMask(document);
    if (document.isEmpty || document.length != 11) {
      return false;
    }

    var validatorDigit = '';
    var validatorDigitOriginal = document.substring(9, 11);

    validatorDigit =
        '$validatorDigit${_getValidatorDigit(cpf: document, digitsForLoop: 8)}';
    validatorDigit =
        '$validatorDigit${_getValidatorDigit(cpf: document, digitsForLoop: 9)}';

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
