import 'package:cpf_generator/app/document_manager/controller/document_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  DocumentController controller = DocumentController();
  test('test for controller', () {
    controller.changeDocumentType(DocumentTypeClass.cpf);
    controller.randomDocument;
  });
}
