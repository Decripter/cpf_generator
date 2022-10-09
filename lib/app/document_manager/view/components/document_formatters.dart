import 'package:flutter/services.dart';

abstract class DocumentFormatter extends TextInputFormatter {}

class CPFDocumentFormatter extends DocumentFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueLength = newValue.text.length;
    var selectionIndex = newValue.selection.end;

    if (newValueLength > 14) {
      return oldValue;
    }

    var substrIndex = 0;
    final newText = StringBuffer();

    if (newValueLength == 3) {
      newText.write('${newValue.text.substring(0, substrIndex = 3)}.');
      if (newValue.selection.end >= 2) selectionIndex++;
    }
    if (newValueLength == 7) {
      newText.write('${newValue.text.substring(0, substrIndex = 7)}.');
      if (newValue.selection.end >= 6) selectionIndex++;
    }
    if (newValueLength == 11) {
      newText.write('${newValue.text.substring(0, substrIndex = 11)}-');
      if (newValue.selection.end >= 10) selectionIndex++;
    }

    if (newValueLength >= substrIndex) {
      newText.write(newValue.text.substring(substrIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class CNPJDocumentFormatter extends DocumentFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueLength = newValue.text.length;
    var selectionIndex = newValue.selection.end;

    if (newValueLength > 18) {
      return oldValue;
    }

    var substrIndex = 0;
    final newText = StringBuffer();
    if (newValueLength == 2) {
      newText.write('${newValue.text.substring(0, substrIndex = 2)}.');
      if (newValue.selection.end >= 2) selectionIndex++;
    }
    if (newValueLength == 7) {
      newText.write('${newValue.text.substring(0, substrIndex = 6)}.');
      if (newValue.selection.end >= 5) selectionIndex++;
    }
    if (newValueLength == 11) {
      newText.write('${newValue.text.substring(0, substrIndex = 10)}/');
      if (newValue.selection.end >= 9) selectionIndex++;
    }
    if (newValueLength == 16) {
      newText.write('${newValue.text.substring(0, substrIndex = 15)}-');
      if (newValue.selection.end >= 14) selectionIndex++;
    }

    if (newValueLength >= substrIndex) {
      newText.write(newValue.text.substring(substrIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
