import 'package:document_manager/app/document_manager/controller/document_formatters.dart';
import 'package:document_manager/app/document_manager/controller/document_type.dart';

/// enum for use on radiobutton, the value will be passed to the controller
/// for change the documentType to aply all formatters and hint text
enum DocumentTypeClass {
  /// represents a cpf type
  cpf,

  /// represents a cnpj type

  cnpj,
}

/// class responsable to deal wih all changes and requests from view
class DocumentController {
  /// initialize the documentType with a value
  DocumentType documentType = DocumentType.cpf();

  final DocumentType _cpfType = DocumentType.cpf();
  final DocumentType _cnpjType = DocumentType.cnpj();

  /// change the documentType dased on type selected on view
  void changeDocumentType(DocumentTypeClass typeClass) {
    if (typeClass == DocumentTypeClass.cpf) {
      documentType = _cpfType;
    } else if (typeClass == DocumentTypeClass.cnpj) {
      documentType = _cnpjType;
    }
  }

  /// pass the value frfom form to object documentModel
  set value(String value) => documentType.documentModel.value = value;

  /// recovery the value from documentModel
  String get value => documentType.documentModel.value;

  /// clear the value from the documentodel
  String get clearDocument => documentType.documentModel.value = '';

  /// recovery the document hint format based document type to pass to form
  String get documentHint => documentType.documentFormHint;

  /// recover the document formatter based on document type to apply on the form
  DocumentFormatter get documentFormatter => documentType.documentFormatter;

  /// ask to documentModel a random document based on type of actual documents
  String get randomDocument => documentType.documentModel.value =
      documentType.documentModel.generateMaskedDocument();

  /// verify it the value of document is valid
  bool get isValid => documentType.documentModel
      .validateDocument(documentType.documentModel.value);
}
