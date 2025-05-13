import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_repository/password_repository.dart';
import 'package:shadow_vault/data/password.dart';
import 'package:shadow_vault/views/ocr/ocr.dart';
import '../../widgets/custom_cupertino_button.dart';
import '../../widgets/custom_cupertino_textfield.dart';
import '../../widgets/password_button.dart';
import '../blocs/create_password/password_bloc.dart';
import '../blocs/home_password/home_bloc.dart';

class SheetScaffold extends StatelessWidget {
  const SheetScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordBloc(context.read<PasswordRepository>()),
      child: SheetScaffoldView(),
    );
  }
}

class SheetScaffoldView extends StatefulWidget {
  const SheetScaffoldView({super.key});

  @override
  State<SheetScaffoldView> createState() => _SheetScaffoldViewState();
}

class _SheetScaffoldViewState extends State<SheetScaffoldView> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage;

  void _onSave() {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final password = passwordController.text.trim();

    if (title.isEmpty || description.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'FieldsRequired'.tr();
      });
      return;
    } else {
      setState(() {
        errorMessage = null;
      });
    }
    final result = Password(
      title: title,
      description: description,
      created: DateTime.now(),
      password: password,
    );

    context.read<HomePasswordBloc>().add(SavePassword(result));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('NewPassword'.tr()),
      ),
      child: Center(
        child: BlocListener<PasswordBloc, PasswordState>(
          listener: (context, state) {
            if (state is PasswordGenerated) {
              passwordController.text = state.password;
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Icon(
                            CupertinoIcons.lock_fill,
                            size: 50,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: CustomCupertinoTextField(
                              controller: titleController,
                              placeholder: 'NewPasswordTitle'.tr(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: CustomCupertinoTextField(
                              controller: descriptionController,
                              placeholder: 'NewPasswordDescription'.tr(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: CustomCupertinoTextField(
                              controller: passwordController,
                              placeholder: 'NewPasswordInput'.tr(),
                              suffix: Row(
                                children: [
                                  PasswordButton(
                                    icon: CupertinoIcons.doc_text_viewfinder,
                                    color: Colors.black,
                                    onPressed: () async {
                                      final String? password =
                                          await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => OcrScreen(),
                                        ),
                                      );

                                      if (context.mounted && password != null) {
                                        context.read<PasswordBloc>().add(
                                              SetPassword(password),
                                            );
                                      }
                                    },
                                  ),
                                  PasswordButton(
                                    icon: CupertinoIcons.shuffle,
                                    color: Colors.black,
                                    onPressed: () {
                                      context.read<PasswordBloc>().add(
                                            GeneratePassword(
                                              passwordLength: 26,
                                              isWithLetters: true,
                                              isWithNumbers: true,
                                              isWithSpecial: true,
                                              isWithUppercase: true,
                                            ),
                                          );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: errorMessage ?? '',
                                  style: TextStyle(
                                    color: CupertinoColors.destructiveRed,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomCupertinoButton(
                                color: CupertinoColors.systemRed,
                                onPressed: () {
                                  Navigator.of(context).maybePop();
                                },
                                text: 'CancelLabel'.tr(),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              CustomCupertinoButton(
                                color: CupertinoColors.activeBlue,
                                onPressed: _onSave,
                                text: 'Oklabel'.tr(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
