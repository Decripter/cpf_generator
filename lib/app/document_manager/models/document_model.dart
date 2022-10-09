abstract class DocumentModel {
  String applyMask(String document);
  bool validateDocument(String document);
  String documentGenerator();
  String generateMaskedDocument();
  String removeMask(String document) {
    String documentClear = document.replaceAll(RegExp(r'\D'), '');
    return documentClear;
  }
}
