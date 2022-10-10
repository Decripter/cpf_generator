import 'package:cpf_generator/app/document_manager/models/cnpj_document_model.dart';
import 'package:cpf_generator/app/document_manager/models/document_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String cnpjWithMask = '57.240.532/0001-13';
  String cnpjWithoutMask = '57240532000113';
  String cnpjValid = '57.240.532/0001-13';
  String cnpjInvalid = '50.204.512/0001-23';
  DocumentModel documentManager = CNPJDocumentModel('');
  test('shoud return true for validation of this valid cnpj', () {
    var result = documentManager.validateDocument(cnpjValid);
    expect(result, true);
  });
  test('shoud return false when validate this cnpj invalid', () {
    var result = documentManager.validateDocument(cnpjInvalid);
    expect(result, false);
  });

  test('should return a cnpj masked', () {
    var result = documentManager.applyMask(cnpjWithoutMask);
    assert(result == cnpjWithMask);
  });
  test('should return a cnpj without mask', () {
    var result = documentManager.removeMask(cnpjWithMask);
    assert(result == cnpjWithoutMask);
  });
  test('should return a cnpj without mask passing by applyMask', () {
    var cnpjWithMask = documentManager.applyMask(cnpjWithoutMask);
    var result = documentManager.removeMask(cnpjWithMask);
    assert(result == cnpjWithoutMask);
  });

  test('shoud return true for validation of this invalid cnpj2', () {
    bool isValid = documentManager.validateDocument('11.222.333/0001-00');
    expect(isValid, false);
  });
  test('shoud return true for validation of this valid cnpj2', () {
    bool isValid = documentManager.validateDocument('11.222.333/0001-81');
    expect(isValid, true);
  });

  test('should generate a cnpj valid and get validated', () {
    String document = documentManager.documentGenerator();
    bool result = documentManager.validateDocument(document);
    expect(result, true);
  });
}
