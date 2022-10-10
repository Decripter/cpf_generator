import 'package:cpf_generator/app/document_manager/controller/document_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DocumentManagerPage extends StatefulWidget {
  const DocumentManagerPage({super.key});

  @override
  State<DocumentManagerPage> createState() => _DocumentManagerPageState();
}

class _DocumentManagerPageState extends State<DocumentManagerPage> {
  late DocumentTypeClass _documentTypeClass;
  DocumentController controller = DocumentController();

  late bool _isValid;
  late FocusNode _textFieldFocusNode;
  late TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    _documentTypeClass = DocumentTypeClass.cpf;
    _textController = TextEditingController();
    _isValid = controller.isValid;
    _textFieldFocusNode = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Color valid = Color.fromARGB(255, 223, 248, 216);
    const Color invalid = Color.fromARGB(255, 248, 218, 216);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Document Manager"),
      ),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            color: _isValid ? valid : invalid,
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
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
                              RegExp(r"[\d./-]+")),
                          controller.documentFormatter
                        ],
                      ),
                    ),
                    _isValid
                        ? const Icon(Icons.verified, color: Colors.green)
                        : const Icon(Icons.cancel, color: Colors.red),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 38.0, bottom: 38.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _textController.text = controller.clearDocument;
                          _textFieldFocusNode.requestFocus();
                          setState(() {
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
                          child: const Text('CHECK')),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: const Text("CPF"),
                        value: DocumentTypeClass.cpf,
                        groupValue: _documentTypeClass,
                        onChanged: (DocumentTypeClass? documentType) {
                          _documentTypeClass = documentType!;
                          setState(() {
                            _textController.text = controller.clearDocument;
                            _isValid = false;
                            _textFieldFocusNode.requestFocus();
                            controller.changeDocumentType(documentType);
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text("CNPJ"),
                        value: DocumentTypeClass.cnpj,
                        groupValue: _documentTypeClass,
                        onChanged: (DocumentTypeClass? documentType) {
                          _documentTypeClass = documentType!;
                          setState(() {
                            _textController.text = controller.clearDocument;

                            _isValid = false;
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
