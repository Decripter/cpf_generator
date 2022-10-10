import 'package:cpf_generator/app/document_manager/controller/document_type.dart';

class DocumentController {
  final DocumentType cpfType = DocumentType.cpf();
  final DocumentType cnpjType = DocumentType.cnpj();

  DocumentType setCpfDocumentType() {
    return cpfType;
  }

  DocumentType setCnpjDocumentType() {
    return cnpjType;
  }
}
