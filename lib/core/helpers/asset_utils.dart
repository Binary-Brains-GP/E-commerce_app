import 'package:flutter/services.dart';

Future<bool> imageExists(String assetPath) async {
  try {
    await rootBundle.load(assetPath);
    return true;
  } catch (e) {
    return false;
  }
}
