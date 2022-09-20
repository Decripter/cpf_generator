class CpfManager {
  @override
  String cpfGenerator() {
    // TODO: implement cpfGenerator
    throw UnimplementedError();
  }

  @override
  bool cpfValidator(String cpf) {
    if (cpf.isEmpty) {
      return false;
    }
    return true;
  }
}
