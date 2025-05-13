import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocr_repository/ocr_repository.dart';
import 'package:password_repository/password_repository.dart';
import 'package:shadow_vault/views/blocs/create_password/password_bloc.dart';
import '../blocs/Ocr/ocr_bloc.dart';

class OcrScreen extends StatelessWidget {
  const OcrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OcrBloc()),
        BlocProvider(
          create: (context) => PasswordBloc(context.read<PasswordRepository>()),
        ),
      ],
      child: const OcrScreenView(),
    );
  }
}

class OcrScreenView extends StatelessWidget {
  const OcrScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final OcrRepository ocrRepository = OcrRepository();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'ScannPassword'.tr(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Text(
              "FocusOnPassword".tr(),
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Live OCR scanning section
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black54, width: 1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ocrRepository.getOcrWidget((text) {
                    context.read<OcrBloc>().add(OcrTextDetected(text));
                  }),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Detected text section with editing option
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: BlocBuilder<OcrBloc, OcrState>(
                  builder: (context, state) {
                    if (state is OcrTextUpdated) {
                      return _DetectedTextBox(text: state.text);
                    }
                    return Text(
                      'StartScanning'.tr(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontStyle: FontStyle.italic,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),

            BlocBuilder<OcrBloc, OcrState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state is OcrTextUpdated
                      ? () => Navigator.pop(context, state.text)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        state is OcrTextUpdated ? Colors.black : Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Donelabel'.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DetectedTextBox extends StatelessWidget {
  final String text;

  const _DetectedTextBox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "TextDetected".tr(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            enabled: false,
            controller: TextEditingController(text: text),
            style: const TextStyle(color: Colors.black, fontSize: 18),
            maxLines: 3,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
