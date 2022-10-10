import 'document_formatters.dart';
import 'package:cpf_generator/app/document_manager/models/cnpj_document_model.dart';
import 'package:cpf_generator/app/document_manager/models/cpf_document_model.dart';
import 'package:cpf_generator/app/document_manager/models/document_model.dart';

enum DocumentTypeClass { cpf, cnpj }

class DocumentType {
  final String documentFormHint;
  final DocumentModel documentModel;
  final DocumentTypeClass documentTypeClass;
  final DocumentFormatter documentFormatter;

  DocumentType({
    required this.documentModel,
    required this.documentFormHint,
    required this.documentFormatter,
    required this.documentTypeClass,
  });
  factory DocumentType.cpf() {
    return DocumentType(
      documentFormHint: 'CPF',
      documentModel: CPFDocumentModel(''),
      documentFormatter: CPFDocumentFormatter(),
      documentTypeClass: DocumentTypeClass.cpf,
    );
  }

  factory DocumentType.cnpj() {
    return DocumentType(
      documentFormHint: 'CNPJ',
      documentModel: CNPJDocumentModel(''),
      documentFormatter: CNPJDocumentFormatter(),
      documentTypeClass: DocumentTypeClass.cnpj,
    );
  }
}
