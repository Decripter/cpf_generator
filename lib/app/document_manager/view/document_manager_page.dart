import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controller/document_type.dart';

class DocumentManagerPage extends StatefulWidget {
  const DocumentManagerPage({super.key});

  @override
  State<DocumentManagerPage> createState() => _DocumentManagerPageState();
}

class _DocumentManagerPageState extends State<DocumentManagerPage> {
  late bool _isValid;
  late DocumentType? _document;
  late FocusNode _textFieldFocusNode;
  late TextEditingController _textEditDocumentController;

  @override
  void initState() {
    _isValid = false;
    _document = DocumentType.cpf();
    _textFieldFocusNode = FocusNode();
    _textEditDocumentController = TextEditingController();

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
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    focusNode: _textFieldFocusNode,
                    controller: _textEditDocumentController,
                    decoration: InputDecoration(
                      hintText: _document!.documentFormHint,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r"[\d./-]+")),
                      _document!.documentFormatter
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
                      _textEditDocumentController.text = '';
                      _textFieldFocusNode.requestFocus();
                      setState(() {
                        _isValid = false;
                      });
                    },
                    child: const Text('CLEAR'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          String document = _textEditDocumentController.text;
                          _isValid = _document!.documentModel
                              .validateDocument(document);
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
                    value: DocumentType.cpf().documentTypeClass,
                    groupValue: _document!.documentTypeClass,
                    onChanged: (DocumentTypeClass? value) {
                      setState(() {
                        _textEditDocumentController.text = '';
                        _isValid = false;
                        _textFieldFocusNode.requestFocus();
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
                        _textEditDocumentController.text = '';
                        _isValid = false;
                        _textFieldFocusNode.requestFocus();
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
          _textEditDocumentController.text =
              _document!.documentModel.generateMaskedDocument();
        },
        child: const Icon(Icons.casino),
      ),
    );
  }
}
