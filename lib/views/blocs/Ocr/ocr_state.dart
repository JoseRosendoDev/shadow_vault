part of 'ocr_bloc.dart';

@immutable
sealed class OcrState extends Equatable {}

class OcrInitial extends OcrState {
  @override
  List<Object?> get props => [];
}

class OcrTextUpdated extends OcrState {
  final String text;
  OcrTextUpdated(this.text);
  
  @override
  List<Object?> get props => [text];
}
