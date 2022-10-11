// ignore_for_file: public_member_api_docs

import 'dart:math';

import 'document_model.dart';

class CPFDocumentModel extends DocumentModel {
  @override
  // ignore: overridden_fields
  String value;
  CPFDocumentModel(this.value);

  @override
  String documentGenerator() {
    var document = '';
    final documentBuffer = StringBuffer(document);
    for (var digit = 0; digit < 9; digit++) {
      documentBuffer.write('$document${Random().nextInt(9)}');
    }
    document = documentBuffer.toString();

    return document = _applyValidatorDigit(document: document);
  }

  @override
  String generateMaskedDocument() {
    final document = documentGenerator();
    final documentMasked = applyMask(document);
    return documentMasked;
  }

  @override
  String applyMask(String document) {
    var documentMasked = '';
    for (var digit = 0; digit < document.length; digit++) {
      if (digit == 3 || digit == 6) {
        documentMasked = '$documentMasked.${document[digit]}';
      } else if (digit == 9) {
        documentMasked = '$documentMasked-${document[digit]}';
      } else {
        documentMasked = '$documentMasked${document[digit]}';
      }
    }
    return documentMasked;
  }

  @override
  bool validateDocument(String document) {
    var documentToValidate = removeMask(document);
    final documentOriginal = documentToValidate;

    if (documentToValidate.isEmpty || documentToValidate.length != 11) {
      return false;
    }

    documentToValidate = documentToValidate.substring(0, 9);
    documentToValidate = _applyValidatorDigit(document: documentToValidate);

    return documentOriginal == documentToValidate;
  }

  String _applyValidatorDigit({
    required String document,
  }) {
    var documentWithDigit = document;
    while (documentWithDigit.length < 11) {
      var cpfSum = 0;
      var mult = 2;
      for (var digit = documentWithDigit.length - 1; digit >= 0; digit--) {
        cpfSum = (int.parse(documentWithDigit[digit]) * mult) + cpfSum;
        mult++;
      }

      if (cpfSum % 11 < 2) {
        documentWithDigit = '${documentWithDigit}0';
      } else {
        documentWithDigit = '$documentWithDigit${11 - (cpfSum % 11)}';
      }
    }
    return documentWithDigit;
  }
}
