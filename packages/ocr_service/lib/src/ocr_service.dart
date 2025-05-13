import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';
import 'package:flutter/material.dart';

class OcrService {
  Widget buildOcrWidget(Function(String) setText) {
    return ScalableOCR(
      paintboxCustom: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0
        ..color = const Color.fromARGB(153, 102, 160, 241),
      boxLeftOff: 4,
      boxBottomOff: 2.7,
      boxRightOff: 4,
      boxTopOff: 2.7,
      boxHeight: 250,
      getRawData: (value) {},
      getScannedText: (value) {
        setText(value);
      },
    );
  }
}
