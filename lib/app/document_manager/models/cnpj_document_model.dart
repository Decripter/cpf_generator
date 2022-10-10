import 'dart:math';

import 'document_model.dart';

class CNPJDocumentModel extends DocumentModel {
  String value;

  CNPJDocumentModel(this.value);

  @override
  String documentGenerator() {
    var document = '';
    for (int digit = 0; digit < 8; digit++) {
      document = '$document${Random().nextInt(9)}';
    }
    document = '${document}000';
    document = '$document${Random().nextInt(8) + 1}';

    document = getValidatorDigit(document: document, mult: 5, loopFor: 12);
    document = getValidatorDigit(document: document, mult: 6, loopFor: 13);
    return document;
  }

  @override
  bool validateDocument(String document) {
    document = removeMask(document);
    String documentOriginal = document;

    document = document.substring(0, 12);

    document = getValidatorDigit(document: document, mult: 5, loopFor: 12);
    document = getValidatorDigit(document: document, mult: 6, loopFor: 13);

    bool result = documentOriginal == document;
    return result;
  }

  String getValidatorDigit(
      {required String document, required int mult, required int loopFor}) {
    var sumDigits = 0;
    for (int digit = 0; digit < loopFor; digit++) {
      sumDigits = sumDigits + (mult * int.parse(document[digit]));
      mult--;
      if (mult == 1) {
        mult = 9;
      }
    }

    if (sumDigits % 11 < 2) {
      document = "${document}0";
    } else {
      document = "$document${11 - (sumDigits % 11)}";
    }
    return document;
  }

  @override
  String applyMask(String document) {
    String documentMasked = '';
    for (int digit = 0; digit < document.length; digit++) {
      if (digit == 1 || digit == 4) {
        documentMasked = "$documentMasked${document[digit]}.";
      } else if (digit == 7) {
        documentMasked = "$documentMasked${document[digit]}/";
      } else if (digit == 11) {
        documentMasked = "$documentMasked${document[digit]}-";
      } else {
        documentMasked = "$documentMasked${document[digit]}";
      }
    }
    return documentMasked;
  }

  @override
  String generateMaskedDocument() {
    String document = documentGenerator();
    document = applyMask(document);
    return document;
  }
}
