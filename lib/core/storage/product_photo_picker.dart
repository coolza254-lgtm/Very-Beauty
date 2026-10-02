import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

/// Gets a product photo from the camera or the gallery. Override in tests.
abstract class ProductPhotoPicker {
  /// Null when the user cancels.
  Future<Uint8List?> pick({required bool fromCamera});
}

class ImagePickerProductPhotoPicker implements ProductPhotoPicker {
  const ImagePickerProductPhotoPicker();

  @override
  Future<Uint8List?> pick({required bool fromCamera}) async {
    final file = await ImagePicker().pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      // Big enough for a sharp product shot; PhotoStorage resizes and strips
      // metadata anyway.
      maxWidth: 2400,
      maxHeight: 2400,
      requestFullMetadata: false,
    );
    return file?.readAsBytes();
  }
}

final productPhotoPickerProvider = Provider<ProductPhotoPicker>(
  (ref) => const ImagePickerProductPhotoPicker(),
);
