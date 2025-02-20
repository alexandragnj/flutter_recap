import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recap/constants/routes.dart';
import 'package:flutter_recap/services/auth/auth_service.dart';
import 'package:flutter_recap/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_recap/services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
      ),
      body: Column(
        children: [
          const Text('We\'ve sent you an email varification'),
          const Text(
              'If you haven\'t received an email, press the button below'),
          TextButton(
            onPressed: () async {
              context
                  .read<AuthBloc>()
                  .add(const AuthEventSendEmailVerification());
            },
            child: Text('Send email verification'),
          ),
          TextButton(
              onPressed: () async {
                context.read<AuthBloc>().add(const AuthEventLogout());
              },
              child: Text('Restart'))
        ],
      ),
    );
  }
}
