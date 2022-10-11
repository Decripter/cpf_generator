import 'package:cpf_generator/app/document_manager/controller/document_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///DocumentManager page
class DocumentManagerPage extends StatefulWidget {
  ///Constructor
  const DocumentManagerPage({super.key});

  @override
  State<DocumentManagerPage> createState() => _DocumentManagerPageState();
}

class _DocumentManagerPageState extends State<DocumentManagerPage> {
  late bool _isValid;
  late FocusNode _textFieldFocusNode;
  late DocumentTypeClass _documentTypeClass;

  DocumentController controller = DocumentController();
  TextEditingController _textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _documentTypeClass = DocumentTypeClass.cpf;
    _textController = TextEditingController();
    _isValid = controller.isValid;
    _textFieldFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    const valid = Color.fromARGB(255, 223, 248, 216);
    const invalid = Color.fromARGB(255, 248, 218, 216);
    const validIcon = Icon(Icons.verified, color: Colors.green);
    const invalidIcon = Icon(Icons.cancel, color: Colors.red);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Manager'),
      ),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            color: _isValid ? valid : invalid,
          ),
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        autofocus: true,
                        focusNode: _textFieldFocusNode,
                        controller: _textController,
                        onChanged: (value) {
                          setState(() {
                            controller.value = value;
                            _isValid = controller.isValid;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: controller.documentHint,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[\d./-]+'),
                          ),
                          controller.documentFormatter
                        ],
                      ),
                    ),
                    if (_isValid) validIcon else invalidIcon,
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 38, bottom: 38),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _textController.text = controller.clearDocument;
                            _textFieldFocusNode.requestFocus();
                            _isValid = controller.isValid;
                          });
                        },
                        child: const Text('CLEAR'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            controller.value = _textController.text;
                            _isValid = controller.isValid;
                          });
                        },
                        child: const Text('CHECK'),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: const Text('CPF'),
                        value: DocumentTypeClass.cpf,
                        groupValue: _documentTypeClass,
                        onChanged: (DocumentTypeClass? documentType) {
                          setState(() {
                            _documentTypeClass = documentType!;
                            _textController.text = controller.clearDocument;
                            _isValid = controller.isValid;
                            _textFieldFocusNode.requestFocus();
                            controller.changeDocumentType(documentType);
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('CNPJ'),
                        value: DocumentTypeClass.cnpj,
                        groupValue: _documentTypeClass,
                        onChanged: (DocumentTypeClass? documentType) {
                          _documentTypeClass = documentType!;
                          setState(() {
                            _textController.text = controller.clearDocument;
                            _isValid = controller.isValid;
                            _textFieldFocusNode.requestFocus();
                            controller.changeDocumentType(documentType);
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _textController.text = controller.randomDocument;
            _isValid = controller.isValid;
          });
        },
        child: const Icon(Icons.casino),
      ),
    );
  }
}
