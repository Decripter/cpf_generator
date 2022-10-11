// ignore_for_file: public_member_api_docs

/// Class base for other documents
abstract class DocumentModel {
  late String value;
  String applyMask(String document);
  bool validateDocument(String document);
  String documentGenerator();
  String generateMaskedDocument();

  /// It's responsable to remove the mask( . - / ) of documents
  String removeMask(String document) {
    final documentClean = document.replaceAll(RegExp(r'\D'), '');
    return documentClean;
  }
}
