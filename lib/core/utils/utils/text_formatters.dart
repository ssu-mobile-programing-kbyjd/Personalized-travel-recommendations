import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CommaFormatter extends TextInputFormatter {
  CommaFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final numberStr = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final int parsedInt = int.parse(numberStr);
    final formatter = NumberFormat.currency(locale: 'ko', symbol: '');
    String newText = formatter.format(parsedInt);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class PrefixInputFormatter extends TextInputFormatter {
  final String prefix;

  PrefixInputFormatter(this.prefix);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (!newValue.text.startsWith(prefix)) {
      final newText = prefix + newValue.text.replaceFirst(prefix, '');
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    return newValue;
  }
}
