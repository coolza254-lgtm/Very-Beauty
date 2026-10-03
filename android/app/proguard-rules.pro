# ML Kit text recognition: only the bundled Latin model is shipped; the
# plugin references the Chinese/Devanagari/Japanese/Korean models at compile
# time only, so R8 must not fail on those missing classes.
-dontwarn com.google.mlkit.vision.text.chinese.**
-dontwarn com.google.mlkit.vision.text.devanagari.**
-dontwarn com.google.mlkit.vision.text.japanese.**
-dontwarn com.google.mlkit.vision.text.korean.**
