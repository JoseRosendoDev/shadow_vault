import 'package:auth_local_repository/auth_local_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:shadow_vault/views/Home/home_view.dart';
import 'package:shadow_vault/views/auth_view/auth_view.dart';
import 'package:shadow_vault/views/blocs/auth/auth_local_bloc.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthLocalBloc(context.read<AuthRepository>()),
      child: AuthBuilder(),
    );
  }
}

class AuthBuilder extends StatefulWidget {
  const AuthBuilder({super.key});

  @override
  State<AuthBuilder> createState() => _AuthBuilderState();
}

class _AuthBuilderState extends State<AuthBuilder> {
  final _noScreenshot = NoScreenshot.instance;
  @override
  void initState() {
    disableScreenshot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthLocalBloc, AuthLocalState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return HomeView();
        } 
        if (state is Unthenticated) {
          return BiometricAuthScreen();
        }
         else {
          return BiometricAuthScreen();
        }
      },
    );
  }

  void disableScreenshot() async {
    await _noScreenshot.screenshotOff();
  }
}
