import 'package:document_manager/app/document_manager/controller/document_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return a document valid', () {
    final controller = DocumentController()
      ..changeDocumentType(DocumentTypeClass.cpf)
      ..randomDocument;
    final result = controller.isValid;
    expect(result, true);
  });
}
