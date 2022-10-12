import 'dart:math';

import 'document_model.dart';

///CNPJDocument class
class CNPJDocumentModel extends DocumentModel {
  @override
  // ignore: overridden_fields
  String value;

  ///constructor
  CNPJDocumentModel(this.value);

  @override
  String documentGenerator() {
    var document = '';
    final documentBuffer = StringBuffer(document);

    for (var digit = 0; digit < 8; digit++) {
      documentBuffer.write('$document${Random().nextInt(9)}');
    }
    documentBuffer
      ..write('${document}000')
      ..write('$document${Random().nextInt(8) + 1}');
    document = documentBuffer.toString();

    document = applyValidatorDigit(
      document: document,
    );
    document = applyValidatorDigit(
      document: document,
    );
    return document;
  }

  @override
  bool validateDocument(String document) {
    var documentToValidate = removeMask(document);
    final documentOriginal = documentToValidate;
    if (documentToValidate.length != 14) {
      return false;
    }

    documentToValidate = documentToValidate.substring(0, 12);

    documentToValidate = applyValidatorDigit(
      document: documentToValidate,
    );
    documentToValidate = applyValidatorDigit(
      document: documentToValidate,
    );

    final result = documentOriginal == documentToValidate;
    return result;
  }

  /// responsable to take the document without validator digit, calculate it,
  /// and return the document with the validator digit
  String applyValidatorDigit({
    required String document,
  }) {
    var sumDigits = 0;
    var multDigit = document.length - 7;
    var documentWithDigit = document;
    for (var digit = 0; digit < documentWithDigit.length; digit++) {
      sumDigits = sumDigits + (multDigit * int.parse(document[digit]));
      multDigit--;
      if (multDigit == 1) {
        multDigit = 9;
      }
    }

    if (sumDigits % 11 < 2) {
      documentWithDigit = '${document}0';
    } else {
      documentWithDigit = '$document${11 - (sumDigits % 11)}';
    }
    return documentWithDigit;
  }

  @override
  String applyMask(String document) {
    var documentMasked = '';
    for (var digit = 0; digit < document.length; digit++) {
      if (digit == 1 || digit == 4) {
        documentMasked = '$documentMasked${document[digit]}.';
      } else if (digit == 7) {
        documentMasked = '$documentMasked${document[digit]}/';
      } else if (digit == 11) {
        documentMasked = '$documentMasked${document[digit]}-';
      } else {
        documentMasked = '$documentMasked${document[digit]}';
      }
    }
    return documentMasked;
  }

  @override
  String generateMaskedDocument() {
    var document = documentGenerator();

    return document = applyMask(document);
  }
}
