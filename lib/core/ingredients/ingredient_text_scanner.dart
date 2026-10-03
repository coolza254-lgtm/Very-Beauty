import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

/// Reads the text of an ingredient list from a photo or screenshot.
/// Recognition runs on the phone (bundled ML Kit Latin model); the image is
/// never uploaded. Override in tests.
abstract class IngredientTextScanner {
  /// Null when the user cancels picking an image.
  Future<String?> scan({required bool fromCamera});
}

class MlKitIngredientTextScanner implements IngredientTextScanner {
  const MlKitIngredientTextScanner();

  @override
  Future<String?> scan({required bool fromCamera}) async {
    final file = await ImagePicker().pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      requestFullMetadata: false,
    );
    if (file == null) return null;
    final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
    try {
      final result = await recognizer.processImage(
        InputImage.fromFilePath(file.path),
      );
      return result.text;
    } finally {
      await recognizer.close();
    }
  }
}

final ingredientTextScannerProvider = Provider<IngredientTextScanner>(
  (ref) => const MlKitIngredientTextScanner(),
);
