import 'package:google_ml_kit/google_ml_kit.dart';

Future<void> analyzeImage(String filePath) async {
  final inputImage = InputImage.fromFilePath(filePath);
  final imageLabeler = GoogleMlKit.vision.imageLabeler();

  final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
  for (ImageLabel label in labels) {
    print('Label: ${label.label}, Confidence: ${label.confidence}');
    // Wybierz odpowiednią kategorię reklamy na podstawie etykiety
  }

  imageLabeler.close();
}
