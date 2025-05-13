import 'package:auth_local_repository/auth_local_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocr_repository/ocr_repository.dart';
import 'package:password_repository/password_repository.dart';
import 'package:shadow_vault/objectbox.g.dart';
import 'package:shadow_vault/simple_bloc_observer.dart';

import 'data/password.dart';
import 'theme/theme.dart';
import 'views/auth_view/auth.dart';
import 'views/blocs/home_password/home_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final Store store = await openStore();
  final box = store.box<Password>();
  Bloc.observer = SimpleBlocObserver();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('es')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: BlocProvider(
        create: (context) => HomePasswordBloc(box),
        child: MainApp(),
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => PasswordRepository(),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => OcrRepository(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: myTheme,
        debugShowCheckedModeBanner: false,
        home: Auth(),
      ),
    );
  }
}
