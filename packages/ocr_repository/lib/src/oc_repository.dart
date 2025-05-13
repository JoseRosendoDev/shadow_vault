import 'package:flutter/material.dart';
import 'package:ocr_service/ocr_service.dart';

class OcrRepository {
  final OcrService _ocrService;

  OcrRepository({OcrService? ocrService})
      : _ocrService = ocrService ?? OcrService();

  Widget getOcrWidget(Function(String) setText) {
    return _ocrService.buildOcrWidget(setText);
  }
}
