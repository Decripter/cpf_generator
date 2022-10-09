import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/document_type.dart';

class DocumentManagerPage extends StatefulWidget {
  const DocumentManagerPage({Key? key}) : super(key: key);

  @override
  State<DocumentManagerPage> createState() => _DocumentManagerPageState();
}

class _DocumentManagerPageState extends State<DocumentManagerPage> {
  late TextEditingController documentController;
  late FocusNode textFieldFocusNode;
  late bool _isValid;
  late DocumentType? _document;

  @override
  void initState() {
    _document = DocumentType.cpf();
    textFieldFocusNode = FocusNode();
    documentController = TextEditingController();
    textFieldFocusNode.requestFocus();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Document Manager"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              autofocus: true,
              focusNode: textFieldFocusNode,
              controller: documentController,
              decoration: InputDecoration(
                hintText: _document!.documentFormHint,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[\d./-]+")),
                _document!.documentFormatter
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38.0, bottom: 38.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      documentController.text = '';
                    },
                    child: const Text('CLEAR'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        String document = documentController.text;
                        _isValid =
                            _document!.documentModel.validateDocument(document);
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
                    value: DocumentType.cpf().documentTypeClass,
                    groupValue: _document!.documentTypeClass,
                    onChanged: (DocumentTypeClass? value) {
                      setState(() {
                        documentController.text = '';
                        textFieldFocusNode.requestFocus();
                        _document = DocumentType.cpf();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text("CNPJ"),
                    value: DocumentType.cnpj().documentTypeClass,
                    groupValue: _document!.documentTypeClass,
                    onChanged: (DocumentTypeClass? value) {
                      setState(() {
                        documentController.text = '';
                        textFieldFocusNode.requestFocus();
                        _document = DocumentType.cnpj();
                      });
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          documentController.text =
              _document!.documentModel.generateMaskedDocument();
        },
        child: const Icon(Icons.casino),
      ),
    );
  }
}
