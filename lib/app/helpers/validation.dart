import 'package:get/get.dart';

abstract class Validation {
  static String? formField({
    required String titleField,
    required String? value,
    isNumericOnly = false,
    int? length,
  }) {
    if (value != null) {
      if (value.isEmpty) {
        return '$titleField harus di isi!';
      }

      if (isNumericOnly) {
        if (!value.isNumericOnly) {
          return '$titleField harus berupa angka!';
        }
      }

      if (length != null) {
        return '$titleField minimal harus $length karakter!';
      }
    }
    return null;
  }
}
