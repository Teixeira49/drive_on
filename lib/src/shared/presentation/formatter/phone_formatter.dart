import 'package:flutter/services.dart';

import '../../../core/utils/constants/app_constants.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (text.length > 12) {
      return oldValue;
    }

    String formattedText = emptyString;
    if (text.length >= 1) {
      formattedText += '+${text.substring(0, 1)}';
    }
    if (text.length >= 2) {
      formattedText += text.substring(1, 2);
    }
    if (text.length >= 3) {
      formattedText += ' ${text.substring(2, 3)}';
    }
    if (text.length >= 4) {
      formattedText += text.substring(3, 4);
    }
    if (text.length >= 5) {
      formattedText += text.substring(4, 5);
    }
    if (text.length >= 6) {
      formattedText += ' ${text.substring(5, 6)}';
    }
    if (text.length >= 7) {
      formattedText += text.substring(6, 7);
    }
    if (text.length >= 8) {
      formattedText += text.substring(7, 8);
    }
    if (text.length >= 9) {
      formattedText += '-${text.substring(8, 9)}';
    }
    if (text.length >= 10) {
      formattedText += text.substring(9, 10);
    }
    if (text.length >= 11) {
      formattedText += text.substring(10, 11);
    }
    if (text.length >= 12) {
      formattedText += text.substring(11, 12);
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}