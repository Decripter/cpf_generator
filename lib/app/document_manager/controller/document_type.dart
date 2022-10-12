import 'package:document_manager/app/document_manager/models/cnpj_document_model.dart';
import 'package:document_manager/app/document_manager/models/cpf_document_model.dart';
import 'package:document_manager/app/document_manager/models/document_model.dart';

import 'document_formatters.dart';

/// this is a bunch of behavior that a document must have
/// that the view layer will use
class DocumentType {
  /// define the hint that the form will show to user
  final String documentFormHint;

  /// define the DocumentModel with yours attributes and methods
  final DocumentModel documentModel;

  /// define the formatter to form
  final DocumentFormatter documentFormatter;

  ///define the constructor
  DocumentType({
    required this.documentModel,
    required this.documentFormHint,
    required this.documentFormatter,
  });

  /// create a DocumentType with attributes that a cpf must have
  factory DocumentType.cpf() {
    return DocumentType(
      documentFormHint: 'CPF',
      documentModel: CPFDocumentModel(''),
      documentFormatter: CPFDocumentFormatter(),
    );
  }

  /// create a DocumentType with attributes that a cnpj must have
  factory DocumentType.cnpj() {
    return DocumentType(
      documentFormHint: 'CNPJ',
      documentModel: CNPJDocumentModel(''),
      documentFormatter: CNPJDocumentFormatter(),
    );
  }
}
