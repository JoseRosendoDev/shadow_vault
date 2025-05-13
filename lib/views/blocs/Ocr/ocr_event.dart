part of 'ocr_bloc.dart';

@immutable
sealed class OcrEvent extends Equatable {}

class OcrTextDetected extends OcrEvent {
  final String text;
  OcrTextDetected(this.text);
  
  @override
  List<Object?> get props => [text];
}
