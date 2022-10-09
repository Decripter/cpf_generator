import 'document_model.dart';

class CNPJDocumentModel extends DocumentModel {
  String value;

  CNPJDocumentModel(this.value);

  @override
  String documentGenerator() {
    // TODO: implement documentGenerator
    throw UnimplementedError();
  }

  @override
  String removeMask(String document) {
    // TODO: implement removeMask
    throw UnimplementedError();
  }

  @override
  bool validateDocument(String document) {
    // TODO: implement validateDocument
    throw UnimplementedError();
  }

  @override
  String applyMask(String document) {
    // TODO: implement applyMask
    throw UnimplementedError();
  }

  @override
  String generateMaskedDocument() {
    // TODO: implement generateMaskedDocument
    throw UnimplementedError();
  }
}
