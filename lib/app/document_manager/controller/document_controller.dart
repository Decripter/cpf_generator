import 'package:cpf_generator/app/document_manager/controller/document_type.dart';

enum DocumentTypeClass { cpf, cnpj }

class DocumentController {
  DocumentType documentType = DocumentType.cpf();

  final DocumentType _cpfType = DocumentType.cpf();
  final DocumentType _cnpjType = DocumentType.cnpj();

  changeDocumentType(DocumentTypeClass typeClass) {
    if (typeClass == DocumentTypeClass.cpf) {
      documentType = _cpfType;
    } else if (typeClass == DocumentTypeClass.cnpj) {
      documentType = _cnpjType;
    }
  }

  set value(String value) => documentType.documentModel.value = value;
  get clearDocument => documentType.documentModel.value = '';
  get randomDocument => documentType.documentModel.value =
      documentType.documentModel.generateMaskedDocument();
  get documentHint => documentType.documentFormHint;
  get documentFormatter => documentType.documentFormatter;
  get isValid => documentType.documentModel
      .validateDocument(documentType.documentModel.value);
}
