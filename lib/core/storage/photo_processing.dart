import 'dart:typed_data';

import 'package:image/image.dart' as img;

/// Result of [processPhoto]: a full-size JPEG and a small thumbnail, both
/// without any EXIF/location metadata.
class ProcessedPhoto {
  const ProcessedPhoto(this.full, this.thumb);

  final Uint8List full;
  final Uint8List thumb;
}

/// Input for [processPhoto]; a plain class so it can cross isolates.
class PhotoJob {
  const PhotoJob(
    this.bytes, {
    this.mirror = false,
    this.maxSide = 2000,
    this.thumbSide = 360,
  });

  final Uint8List bytes;

  /// Flip horizontally so selfies match the mirrored preview (and the
  /// onion-skin overlay lines up).
  final bool mirror;
  final int maxSide;
  final int thumbSide;
}

/// Decodes a camera image, applies its orientation, optionally mirrors it,
/// downsizes, and re-encodes it **with all metadata removed**
/// (docs/SPEC.md §7.5). CPU heavy — run it in an isolate.
ProcessedPhoto processPhoto(PhotoJob job) {
  final decoded = img.decodeImage(job.bytes);
  if (decoded == null) {
    throw const FormatException('Unsupported image');
  }
  var image = img.bakeOrientation(decoded);
  if (job.mirror) image = img.flipHorizontal(image);
  image = _fit(image, job.maxSide);
  final thumb = _fit(image, job.thumbSide);

  // Drop every EXIF block (GPS, device, timestamps) before encoding.
  image.exif = img.ExifData();
  thumb.exif = img.ExifData();
  return ProcessedPhoto(
    img.encodeJpg(image, quality: 90),
    img.encodeJpg(thumb, quality: 80),
  );
}

img.Image _fit(img.Image image, int maxSide) {
  final longest = image.width > image.height ? image.width : image.height;
  if (longest <= maxSide) return image.clone();
  return image.width >= image.height
      ? img.copyResize(
          image,
          width: maxSide,
          interpolation: img.Interpolation.average,
        )
      : img.copyResize(
          image,
          height: maxSide,
          interpolation: img.Interpolation.average,
        );
}
