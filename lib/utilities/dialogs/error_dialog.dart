import 'package:flutter/cupertino.dart';
import 'package:flutter_recap/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: 'An error has occured',
    content: text,
    optionBuilder: () => {
      'OK': null,
    },
  );
}
