import 'package:flutter/cupertino.dart';
import 'package:flutter_recap/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password reset',
    content: 'We have sent you a password reset link. Please check your email.',
    optionBuilder: () => {
      'OK': null,
    },
  );
}
