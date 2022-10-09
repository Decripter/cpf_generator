abstract class DocumentModel {
  String removeMask(String document);
  String applyMask(String document);
  bool validateDocument(String document);
  String documentGenerator();
  String generateMaskedDocument();
}
