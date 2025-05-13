import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../blocs/auth/auth_local_bloc.dart';

class BiometricAuthScreen extends StatelessWidget {
  const BiometricAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthLocalBloc>().state;
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthLocalBloc, AuthLocalState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.black,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: 
               Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.fingerprint,
                  size: 150.0,
                  color: Colors.black,
                ),
                SizedBox(height: 30.0),
                Text(
                  'AuthenticateRequired'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                'AuthenticateWithBiometrics'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 40.0),
              state is AuthLoading ? CircularProgressIndicator() : 
               ElevatedButton.icon(
                key: const Key('authenticate_button'),
                icon: Icon(Icons.lock_open, size: 24.0, color: Colors.white),
                label: Text(
                  'Authenticate'.tr(),
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              onPressed: state is AuthLoading
              ? null
              : () {
                  context.read<AuthLocalBloc>().add(AuthStartAuthentication());
                },

                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                  textStyle: TextStyle(fontSize: 18.0),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 1,
                  shadowColor: Colors.black,
                  side: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
