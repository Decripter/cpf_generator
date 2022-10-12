import 'package:cpf_generator/app/document_manager/models/cnpj_document_model.dart';
import 'package:cpf_generator/app/document_manager/models/document_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const cnpjWithMask = '57.240.532/0001-13';
  const cnpjWithoutMask = '57240532000113';
  const cnpjValid = '57.240.532/0001-13';
  const cnpjInvalid = '50.204.512/0001-23';
  final DocumentModel documentManager = CNPJDocumentModel('');
  group('Tests for cnpjModel => ', () {
    test('shoud return true for validation of this valid cnpj', () {
      final result = documentManager.validateDocument(cnpjValid);
      expect(result, true);
    });
    test('shoud return false when validate this cnpj invalid', () {
      final result = documentManager.validateDocument(cnpjInvalid);
      expect(result, false);
    });

    test('should return a cnpj masked', () {
      final result = documentManager.applyMask(cnpjWithoutMask);
      assert(result == cnpjWithMask, 'Must be equal');
    });
    test('should return a cnpj without mask', () {
      final result = documentManager.removeMask(cnpjWithMask);
      assert(result == cnpjWithoutMask, 'Must be equal');
    });
    test('should return a cnpj without mask passing by applyMask', () {
      final cnpjWithMask = documentManager.applyMask(cnpjWithoutMask);
      final result = documentManager.removeMask(cnpjWithMask);
      assert(result == cnpjWithoutMask, 'Must be equal');
    });

    test('shoud return false for validation of this invalid cnpj_2', () {
      final isValid = documentManager.validateDocument('11.222.333/0001-00');
      expect(isValid, false);
    });
    test('shoud return true for validation of this valid cnpj_2', () {
      final isValid = documentManager.validateDocument('11.222.333/0001-81');
      expect(isValid, true);
    });

    test('should generate a cnpj valid and get validated', () {
      final document = documentManager.documentGenerator();
      final result = documentManager.validateDocument(document);
      expect(result, true);
    });
  });
}
